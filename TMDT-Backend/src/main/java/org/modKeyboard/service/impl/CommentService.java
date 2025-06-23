package org.modKeyboard.service.impl;

import java.util.List;
import java.util.UUID;

import org.modKeyboard.dto.request.comment.CommentCreateRequest;
import org.modKeyboard.dto.request.comment.CommentUpdateRequest;
import org.modKeyboard.dto.response.CommentResponse;
import org.modKeyboard.dto.response.PageResponse;
import org.modKeyboard.entity.Comment;
import org.modKeyboard.entity.User;
import org.modKeyboard.exception.ResourceNotFoundException;
import org.modKeyboard.mapper.CommentMapper;
import org.modKeyboard.repository.CommentRepository;
import org.modKeyboard.service.ICommentService;
import org.modKeyboard.service.IProductService;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class CommentService implements ICommentService {
  CommentRepository commentRepository;
  CommentMapper commentMapper;
  IProductService productService;

  @Override
  public void create(CommentCreateRequest request, UUID authorId) {
    var product = productService.findById(request.productId());
    var author = new User(authorId);
    var comment = commentMapper.toComment(request, author, product);
    commentRepository.save(comment);
  }

  @Override
  public void reply(CommentCreateRequest request, UUID authorId, UUID parentId) {
    var parentComment = findByIdOrThrow(parentId);
    if (parentComment.getDepth() >= 2)
      throw new IllegalArgumentException("Max reply depth (3 levels) exceeded");
    var product = productService.findById(request.productId());
    var author = new User(authorId);
    var comment = commentMapper.toComment(request, author, product);
    comment.setParentComment(parentComment);
    commentRepository.save(comment);
  }

  @Override
  public void delete(UUID id) {
    var comment = findByIdOrThrow(id);
    commentRepository.deleteById(comment.getId());
  }

  @Override
  public void update(CommentUpdateRequest request, UUID authorId, UUID id) {
    var currnetComment = findByIdOrThrow(id);
    if (!authorId.equals(currnetComment.getUser().getId()))
      throw new IllegalArgumentException("You do not have permission to update this comment");
    commentMapper.setComment(request, currnetComment);
    commentRepository.save(currnetComment);

  }

  @Override
  public Comment findByIdOrThrow(UUID id) {
    return commentRepository
        .findById(id)
        .orElseThrow(() -> ResourceNotFoundException.from("comment with id: {} not found", id));
  }

  private CommentResponse mapToCommentResponseWithReplies(Comment comment) {
    return commentMapper.toResponse(comment, getReplies(comment, 1));
  }

  private List<CommentResponse> getReplies(Comment parent, int level) {
    if (level >= 3)
      return List.of();
    var children = commentRepository.findByParentCommentId(parent.getId());
    return children
        .stream()
        .map(child -> commentMapper.toResponse(child, getReplies(child, level + 1))).toList();
  }

  @Override
  public PageResponse<List<CommentResponse>> getCommentsWithReplies(PageRequest pageable, UUID productId) {
    var commentsPage = commentRepository.findTopLevelByProductId(productId, pageable);
    var comments = commentsPage.getContent();
    var commentsResponse = comments.stream().map(this::mapToCommentResponseWithReplies).toList();
    return PageResponse.<List<CommentResponse>>builder()
        .currentPage(commentsPage.getNumber() + 1)
        .totalPage(commentsPage.getTotalPages())
        .data(commentsResponse)
        .build();
  }

}

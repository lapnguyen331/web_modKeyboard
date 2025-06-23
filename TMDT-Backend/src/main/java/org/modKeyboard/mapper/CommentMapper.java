package org.modKeyboard.mapper;

import java.util.List;

import org.modKeyboard.dto.request.comment.CommentCreateRequest;
import org.modKeyboard.dto.request.comment.CommentUpdateRequest;
import org.modKeyboard.dto.response.CommentResponse;
import org.modKeyboard.entity.Comment;
import org.modKeyboard.entity.Product;
import org.modKeyboard.entity.User;
import org.springframework.stereotype.Component;

@Component
public class CommentMapper {
  public Comment toComment(CommentCreateRequest request, User author, Product product) {
    var comment = new Comment();
    comment.setUser(author);
    comment.setContent(request.content());
    comment.setProduct(product);
    return comment;
  }

  public void setComment(CommentUpdateRequest request, Comment comment) {
    comment.setContent(request.content());
  }

  public CommentResponse toResponse(Comment comment, List<CommentResponse> replies) {
    var author = new CommentResponse.Author(comment.getUser().getId(), comment.getUser().getFullName());
    return new CommentResponse(
        comment.getId(),
        comment.getProduct().getId(),
        author, comment.getContent(),
        replies,
        comment.getDepth(),
        comment.getCreatedAt());
  }
}

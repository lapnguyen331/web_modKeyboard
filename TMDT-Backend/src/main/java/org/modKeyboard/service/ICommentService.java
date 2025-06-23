package org.modKeyboard.service;

import java.util.List;
import java.util.UUID;

import org.modKeyboard.dto.request.comment.CommentCreateRequest;
import org.modKeyboard.dto.request.comment.CommentUpdateRequest;
import org.modKeyboard.dto.response.CommentResponse;
import org.modKeyboard.dto.response.PageResponse;
import org.modKeyboard.entity.Comment;
import org.springframework.data.domain.PageRequest;

import jakarta.validation.Valid;

public interface ICommentService {

  void create(CommentCreateRequest request, UUID authorId);

  void update(CommentUpdateRequest request, UUID authorId, UUID id);

  Comment findByIdOrThrow(UUID id);

  void delete(UUID id);

  void reply(@Valid CommentCreateRequest request, UUID authorId, UUID parentId);

  PageResponse<List<CommentResponse>> getCommentsWithReplies(PageRequest pageable, UUID productId);

}

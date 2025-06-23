package org.modKeyboard.controller.customer;

import java.util.UUID;

import org.modKeyboard.dto.CustomUserSecurity;
import org.modKeyboard.dto.request.comment.CommentCreateRequest;
import org.modKeyboard.dto.request.comment.CommentUpdateRequest;
import org.modKeyboard.dto.response.ResponseObject;
import org.modKeyboard.service.ICommentService;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;

@RestController
@RequestMapping("${API_PREFIX}/comments")
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@RequiredArgsConstructor
public class CommentController {
  ICommentService commentService;

  @PostMapping
  public ResponseObject<Void> create(@RequestBody @Valid CommentCreateRequest request,
      @AuthenticationPrincipal CustomUserSecurity user) {
    commentService.create(request, user.getId());
    return new ResponseObject<>(HttpStatus.OK, "Comment created");

  }

  @PostMapping("/{parentId}/replies")
  public ResponseObject<Void> reply(@RequestBody @Valid CommentCreateRequest request,
      @PathVariable("parentId") UUID parentId,
      @AuthenticationPrincipal CustomUserSecurity user) {
    commentService.reply(request, user.getId(), parentId);
    return new ResponseObject<>(HttpStatus.OK, "Comment replied");
  }

  @PutMapping("/{id}")
  public ResponseObject<Void> update(@RequestBody @Valid CommentUpdateRequest request,
      @PathVariable("id") UUID id,
      @AuthenticationPrincipal CustomUserSecurity user) {
    commentService.update(request, user.getId(), id);
    return new ResponseObject<>(HttpStatus.OK, "Comment deleted");
  }

  @DeleteMapping("/{id}")
  public ResponseObject<Void> delete(@PathVariable("id") UUID id) {
    commentService.delete(id);
    return new ResponseObject<>(HttpStatus.OK);
  }

}

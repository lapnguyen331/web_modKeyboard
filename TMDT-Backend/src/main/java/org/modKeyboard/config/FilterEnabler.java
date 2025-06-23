package org.modKeyboard.config;

import org.hibernate.Session;
import org.springframework.stereotype.Component;

import jakarta.persistence.EntityManager;
import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class FilterEnabler {
  private final EntityManager entityManager;

  public void enableDeletedFilter() {
    var session = entityManager.unwrap(Session.class);
    session.enableFilter("deletedFilter").setParameter("isDeleted", false);
  }

}

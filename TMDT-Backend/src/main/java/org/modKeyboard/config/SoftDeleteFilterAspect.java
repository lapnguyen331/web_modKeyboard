package org.modKeyboard.config;

import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;

import lombok.RequiredArgsConstructor;

@Aspect
@Component
@RequiredArgsConstructor
public class SoftDeleteFilterAspect {
  private final FilterEnabler filterEnabler;

  @Pointcut("within(org.modKeyboard.service.impl.ProductService)")
  public void softDeletableServiceMethod() {
  };

  @Before("softDeletableServiceMethod()")
  public void before() {
    filterEnabler.enableDeletedFilter();
  }
}

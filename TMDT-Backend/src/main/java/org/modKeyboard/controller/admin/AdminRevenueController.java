package org.modKeyboard.controller.admin;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.modKeyboard.dto.response.ResponseObject;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("${API_PREFIX}/admin/revenues")
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@RequiredArgsConstructor
public class AdminRevenueController {

    @GetMapping()
    public ResponseObject<String> hello() {
        return new ResponseObject<>(HttpStatus.OK, "Hello from Admin Revenue Controller");
    }

}

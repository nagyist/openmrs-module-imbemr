package org.openmrs.module.imbemr.page.controller.patient;

import org.openmrs.Patient;
import org.openmrs.ui.framework.page.PageModel;
import org.springframework.web.bind.annotation.RequestParam;

public class RegimenPageController {

    public void get(PageModel model, @RequestParam("patientId") Patient patient) {
        model.addAttribute("patient", patient);
    }
}

<%
    ui.decorateWith("appui", "standardEmrPage")
%>

${ ui.includeFragment("coreapps", "patientHeader", [ patient: patient.patient ]) }

<script type="text/javascript">
    var breadcrumbs = [
        { icon: "icon-home", link: '/' + OPENMRS_CONTEXT_PATH + '/index.htm' },
        { label: '${ui.encodeJavaScript(ui.encodeHtmlContent(ui.format(patient.patient)))}', link: '${ui.pageLink("registrationapp", "registrationSummary", ["patientId": patient.id, "appId": "imbemr.registerPatient"])}' },
        { label: "${ ui.message("imbemr.insurancePolicies")}" }
    ];
    jq(document).ready(function() {
        jq("#add-new-button").click(function(event) {
            document.location.href = '${ui.pageLink("imbemr", "patient/insurancePolicy", ["patientId": patient.id, "edit": true])}';
        });
    });
</script>

<h3>${ ui.message("imbemr.insurancePolicies") }</h3>

<table id="insurance-policy-table">
    <thead>
        <tr>
            <th>${ ui.message("imbemr.insurance.name") }</th>
            <th>${ ui.message("imbemr.insurance.insuranceCardNo") }</th>
            <th>${ ui.message("imbemr.insurance.coverageStartDate") }</th>
            <th>${ ui.message("imbemr.insurance.expirationDate") }</th>
            <th>${ ui.message("imbemr.insurance.thirdParty") }</th>
            <th>${ ui.message("general.action") }</th>
        </tr>
    </thead>
    <tbody>
    <% if (insurancePolicies.size() == 0) { %>
        <tr>
            <td colspan="5">${ ui.message("emr.none") }</td>
        </tr>
    <% } %>
    <% insurancePolicies.each { policy -> %>
        <tr>
            <td>
                ${ ui.format(policy.insurance?.name) }
            </td>
            <td>
                ${ ui.format(policy.insuranceCardNo) }
            </td>
            <td>
                ${ ui.format(policy.coverageStartDate) }
            </td>
            <td>
                ${ ui.format(policy.expirationDate) }
            </td>
            <td>
                ${ ui.format(policy.thirdParty?.name) }
            </td>
        <td>
            <a href="${ui.pageLink("imbemr", "patient/insurancePolicy", ["patientId": patient.patient.patientId, "policyId": policy.insurancePolicyId])}">
                <i class="icon-caret-right"></i>
            </a>
            <% if (sessionContext.currentUser.hasPrivilege("Edit Insurance Policy")) { %>
                <a href="${ui.pageLink("imbemr", "patient/insurancePolicy", ["patientId": patient.patient.patientId, "policyId": policy.insurancePolicyId, "edit": true, "returnUrl": ui.pageLink("imbemr", "patient/insurancePolicies", ["patientId": patient.id])])}">
                    <i class="icon-pencil"></i>
                </a>
            <% } %>
        </td>
        </tr>
    <% } %>
    </tbody>
</table>
<br/>
<div>
    <% if (sessionContext.currentUser.hasPrivilege("Create Insurance Policy")) { %>
        <input id="add-new-button" type="button" value="${ ui.message("imbemr.insurancePolicies.add") }"/>
    <% } %>
</div>


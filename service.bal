import ballerina/time;
import ballerina/uuid;
import ballerinax/mysql.driver as _;
import ballerina/persist;
import ballerina/log;

isolated function addRequest(NewIdentityRequest newrequest) returns IdentityRequest|error
{
    //check if grama division exists
    GramaDivision|error grama_division = getGramaDivision(newrequest.gramasevaka_division);
    if (grama_division is error) {
        return grama_division;
    }

    IdentityRequest request = {
        id: uuid:createType4AsString(),
        initials_fullname: newrequest.initials_fullname,
        fullname: newrequest.fullname,
        NIC: newrequest.NIC,
        DOB: newrequest.DOB,
        approved_by: "",
        contact_num: newrequest.contact_num,
        address: newrequest.address,
        gender: newrequest.gender,
        grama_divisionId: newrequest.gramasevaka_division,
        applied_date: time:utcNow(),
        email: newrequest.email,
        status: "Pending"
    };

    string[]|error added = dbclient->/identityrequests.post([request]);
    if (added is error) {
        return request;
    }
    return request;

}

isolated function changeRequestStatus(string request_id, string status, string grama_id) returns ()|error {
    IdentityRequest|error updated = dbclient->/identityrequests/[request_id].put({status: status, approved_by: grama_id});
    if (updated is error) {
        return updated;
    }
    return ();
}

isolated function getRequests() returns IdentityRequest[]|error {
    IdentityRequest[]|error requests = from var request in dbclient->/identityrequests(targetType = IdentityRequest)
        select request;
    if requests is error {
        log:printError("Error while retrieving requests from the database", 'error = requests);
        return requests;
    } else {
        return requests;
    }
}

isolated function getRequest(string id) returns IdentityRequest|error {
    IdentityRequest|error request = dbclient->/identityrequests/[id];
    if request is error {
        return request;
    } else {
        return request;
    }
}

isolated function deleteRequest(string id) returns ()|error {
    IdentityRequest|persist:Error deleted = dbclient->/identityrequests/[id].delete();
    if (deleted is error) {
        return deleted;
    }
    return ();
}

isolated function getRequestsByGramaDivision(string grama_division_id) returns IdentityRequest[]|error {
    IdentityRequest[]|error requests = from var request in dbclient->/identityrequests(targetType = IdentityRequest)
        where request.grama_divisionId == grama_division_id
        select request;
    if requests is error {
        log:printError("Error while retrieving requests from the database", 'error = requests);
        return requests;
    } else {
        return requests;
    }
}

isolated function getRequestsByStatus(string status) returns IdentityRequest[]|error {
    IdentityRequest[]|error requests = from var request in dbclient->/identityrequests(targetType = IdentityRequest)
        where request.status == status
        select request;
    if requests is error {
        log:printError("Error while retrieving requests from the database", 'error = requests);
        return requests;
    } else {
        return requests;
    }
}

isolated function getRequestsByStatusAndGramaDivision(string status, string grama_division_id) returns IdentityRequest[]|error {
    IdentityRequest[]|error requests = from var request in dbclient->/identityrequests(targetType = IdentityRequest)
        where request.status == status
        where request.grama_divisionId == grama_division_id
        select request;
    if requests is error {
        log:printError("Error while retrieving requests from the database", 'error = requests);
        return requests;
    } else {
        return requests;
    }
}

isolated function getRequestsByNIC(string nic) returns IdentityRequest[]|error {
    IdentityRequest[]|error requests = from var request in dbclient->/identityrequests(targetType = IdentityRequest)
        where request.NIC == nic
        select request;
    if requests is error {
        log:printError("Error while retrieving requests from the database", 'error = requests);
        return requests;
    } else {
        return requests;
    }
}
isolated function checkDateIsLessThanSixMonthsFromNow(time:Utc date) returns boolean|error {
    time:Utc now = time:utcNow();
    time:Utc six_months_ago = time:utcAddSeconds(now, -15768000);
    if (date<six_months_ago) {
        return false;
    }
    return true;
}

isolated function checkRequestIsValid(IdentityRequest request) returns boolean|error {
    if (request.status == "Rejected" || request.status == "Pending") {
        return false;
    }
    boolean valid_date = check checkDateIsLessThanSixMonthsFromNow(request.applied_date);
    if (!valid_date) {
        return false;
    }
    return true;
}

isolated function checkCitizenHasValidIdentityRequests(string nic) returns boolean|error {
    IdentityRequest[]|error requests = getRequestsByNIC(nic);
    if (requests is error) {
        return false;
    }
    foreach var request in requests {
        boolean valid =check checkRequestIsValid(request);
        if (valid) {
            return true;
        }
    }
    return false;
}
isolated function getGramaDivision(string id) returns GramaDivision|error {
    GramaDivision|error grama_division = dbclient->/gramadivisions/[id];
    if grama_division is error {
        return grama_division;
    } else {
        return grama_division;
    }
}
isolated function getGramaDivisions() returns GramaDivision[]|error {
    GramaDivision[]|error grama_divisions = from var grama_division in dbclient->/gramadivisions(targetType = GramaDivision)
        select grama_division;
    if grama_divisions is error {
        log:printError("Error while retrieving grama divisions from the database", 'error = grama_divisions);
        return grama_divisions;
    } else {
        return grama_divisions;
    }
}

function initializeDbClient() returns Client|error {
    return new Client();
}

final Client dbclient = check initializeDbClient();


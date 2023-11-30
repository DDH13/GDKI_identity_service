import ballerina/http;
import ballerina/time;

public type NewIdentityRequest record {|
    string initials_fullname;
    string fullname;
    string NIC;
    string gender;
    string contact_num;
    string email;
    string address;
    time:Utc DOB;
    string gramasevaka_division;
|};

public type UpdateStatusRequest record {|
    string grama_nic;
    string request_id;
    string status;
|};

service /identity on new http:Listener(8081) {
    isolated resource function get requests(string gdid = "", string status = "", int rlimit = -1, int offset = -1) returns IdentityRequest[]|error {
        if (gdid != "" && status != "") {
            return getRequestsByStatusAndGramaDivision(status, gdid);
        }
        else if (status != "") {
            return getRequestsByStatus(status);
        }
        else if (gdid != "") {
            return getRequestsByGramaDivision(gdid);
        }
        else {
            return getRequests();
        }
    }
    isolated resource function get requests/[string id]() returns IdentityRequest|error {
        return getRequest(id);
    }
    isolated resource function get requests/validate/[string nic]() returns boolean|error {
        return checkCitizenHasValidIdentityRequests(nic);
    }

    isolated resource function post requests(NewIdentityRequest request) returns IdentityRequest|error {
        return addRequest(request);
    }

    isolated resource function put requests(UpdateStatusRequest request) returns string|error {
        error? changeRequestStatusResult = changeRequestStatus(request.request_id, request.status, request.grama_nic);
        if changeRequestStatusResult is error {
            return changeRequestStatusResult;
        }
        else {
            return request.request_id;
        }
    }

    isolated resource function delete requests/[string id]() returns string |error {
        error? deleteRequestResult = deleteRequest(id);
        if deleteRequestResult is error {
            return deleteRequestResult;
        }
        else {
            return id;
        }
    }

}

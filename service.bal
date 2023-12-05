import ballerina/http;
import ballerina/time;
import ballerinax/vonage.sms as vs;

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
    string grama_name;
    string request_id;
    string status;
|};

@http:ServiceConfig {
    cors: {
        allowOrigins: ["*"]
    }
}

service /identity on new http:Listener(8081) {
    isolated resource function get requests(string gdid = "", string status = "", int rlimit = 10000, int offset = 0) returns IdentityRequest[]|error {
        if (gdid != "" && status != "") {
            return getRequestsByStatusAndGramaDivision(status, gdid, rlimit, offset);
        }
        else if (status != "") {
            return getRequestsByStatus(status, rlimit, offset);
        }
        else if (gdid != "") {
            return getRequestsByGramaDivision(gdid, rlimit, offset);
        }
        else {
            return getRequests(rlimit, offset);
        }
    }
    isolated resource function get requests/[string id]() returns IdentityRequest|error {
        return getRequest(id);
    }
    isolated resource function get requests/nic/[string nic]() returns IdentityRequest[]|error {
        return getRequestsByNIC(nic);
    }
    isolated resource function get requests/latest/[string nic]() returns IdentityRequest|error {
        return getLatestApprovedRequest(nic);
    }
    isolated resource function get requests/validate/[string nic]() returns boolean|error {
        return checkCitizenHasValidIdentityRequests(nic);
    }

    isolated resource function post requests(NewIdentityRequest request) returns IdentityRequest|error {
        return addRequest(request);
    }

    isolated resource function put requests(UpdateStatusRequest request) returns string|error {
        vs:Client vsClient = check getVsClient();

        error? changeRequestStatusResult = changeRequestStatus(request.request_id, request.status, request.grama_name, vsClient);
        if changeRequestStatusResult is error {
            return changeRequestStatusResult;
        }
        else {
            return request.request_id;
        }
    }

    isolated resource function delete requests/[string id]() returns string|error {
        error? deleteRequestResult = deleteRequest(id);
        if deleteRequestResult is error {
            return deleteRequestResult;
        }
        else {
            return id;
        }
    }

    isolated resource function get gramadivisions() returns GramaDivision[]|error {
        return getGramaDivisions();
    }

}

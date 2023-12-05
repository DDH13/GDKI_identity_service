import ballerina/persist as _;
import ballerina/time;

public type IdentityRequest record {|
    readonly string id;
    string initials_fullname;
    string fullname;
    string NIC;
    string gender;
    string contact_num;
    string email;
    string address;
    time:Utc DOB;
    time:Utc applied_date;
    time:Utc approved_date;
    string approved_by;
    string status;
    GramaDivision grama_division;
|};

public type GramaDivision record {|
    readonly string id;
    string province;
    string district;
    string DS_division;
    string GN_division;
	IdentityRequest[] identityrequest;
|};

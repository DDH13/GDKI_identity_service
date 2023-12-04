// AUTO-GENERATED FILE. DO NOT MODIFY.
// This file is an auto-generated file by Ballerina persistence layer for model.
// It should not be modified by hand.
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
    string approved_by;
    string status;
    string grama_divisionId;
|};

public type IdentityRequestOptionalized record {|
    string id?;
    string initials_fullname?;
    string fullname?;
    string NIC?;
    string gender?;
    string contact_num?;
    string email?;
    string address?;
    time:Utc DOB?;
    time:Utc applied_date?;
    string approved_by?;
    string status?;
    string grama_divisionId?;
|};

public type IdentityRequestWithRelations record {|
    *IdentityRequestOptionalized;
    GramaDivisionOptionalized grama_division?;
|};

public type IdentityRequestTargetType typedesc<IdentityRequestWithRelations>;

public type IdentityRequestInsert IdentityRequest;

public type IdentityRequestUpdate record {|
    string initials_fullname?;
    string fullname?;
    string NIC?;
    string gender?;
    string contact_num?;
    string email?;
    string address?;
    time:Utc DOB?;
    time:Utc applied_date?;
    string approved_by?;
    string status?;
    string grama_divisionId?;
|};

public type GramaDivision record {|
    readonly string id;
    string province;
    string district;
    string DS_division;
    string GN_division;
|};

public type GramaDivisionOptionalized record {|
    string id?;
    string province?;
    string district?;
    string DS_division?;
    string GN_division?;
|};

public type GramaDivisionWithRelations record {|
    *GramaDivisionOptionalized;
    IdentityRequestOptionalized[] identityrequest?;
|};

public type GramaDivisionTargetType typedesc<GramaDivisionWithRelations>;

public type GramaDivisionInsert GramaDivision;

public type GramaDivisionUpdate record {|
    string province?;
    string district?;
    string DS_division?;
    string GN_division?;
|};


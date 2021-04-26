create or replace package plsql_archiver
as
procedure archive_version
( p_object_name   in  varchar2
, p_object_type   in  varchar2
, p_object_owner  in varchar2
, p_creation_time in date
);
procedure revert_to_previous_version -- undo last change; can be called repeatedly
( p_object_name   in varchar2
, p_object_type   in varchar2
, p_object_owner  in varchar2
, p_purge_latest  in varchar2 default 'Y' 
);

procedure revert_to_version
( p_object_name   in varchar2
, p_object_type   in varchar2
, p_object_owner  in varchar2
, p_version_label in varchar2
, p_branch        in varchar2
, p_seq           in number
, p_purge_later   in varchar2 default 'N' 
);

/*
procedure revert_to_version
( p_object_name   in varchar2
, p_object_type   in varchar2
, p_object_owner  in varchar2
, p_version_label in varchar2
, p_branch        in varchar2
, p_seq           in number
);
-- wildcards allowed
procedure purge
( p_object_name   in varchar2
, p_object_type   in varchar2
, p_object_owner  in varchar2 
, p_status        in varchar2 default null
, p_priority      in varchar2 default null
, p_from_datetime in date     default null
, p_to_datetime   in date     default null
, p_branch        in varchar2 default null
, p_seq_from      in number   default null
, p_seq_to        in number   default null
);
-- wildcards allowed
-- this procedure will link all specified object versions to the label specified through p_label
procedure create_stripe
( p_label         in varchar2
, p_object_name   in varchar2 
, p_object_type   in varchar2
, p_object_owner  in varchar2 
, p_from_datetime in date     default null
, p_to_datetime   in date     default null
, p_branch        in varchar2 default null
, p_seq           in number   default null
);
*/
function version_graph
( p_object_name   in varchar2
, p_object_type   in varchar2
, p_object_owner  in varchar2 
, p_show_version_label in  varchar2 default 'Y' -- show the version label 
, p_show_seq           in  varchar2 default 'N' -- show the seq value for each version (appended to the version label if that is requested too)
, p_show_datetime      in  varchar2 default 'N' -- display the timestamp of the creation of each version
, p_show_author        in  varchar2 default 'N' -- display the author of each version
, p_show_labels        in  varchar2 default 'N' -- display the labels or stripes a version is associated with
, p_show_status        in  varchar2 default 'N' -- display the status (VALID or INVALID) of the version
, p_show_comments      in  varchar2 default 'N' -- display the Comments for each version
) return string_table
;
end plsql_archiver;
/

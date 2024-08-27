CREATE EXTERNAL TABLE `json_import_parquet`(
  `additional_source_id` string COMMENT 'from deserializer', 
  `additional_source_name` string COMMENT 'from deserializer', 
  `additional_tender_url` string COMMENT 'from deserializer', 
  `attachments` array<struct<external_url:string,file_description:string,file_name:string,file_size:double,file_type:string>> COMMENT 'from deserializer', 
  `bidding_response_method` string COMMENT 'from deserializer', 
  `category` string COMMENT 'from deserializer', 
  `class_at_source` string COMMENT 'from deserializer', 
  `class_codes_at_source` string COMMENT 'from deserializer', 
  `class_title_at_source` string COMMENT 'from deserializer', 
  `completed_steps` string COMMENT 'from deserializer', 
  `contract_duration` string COMMENT 'from deserializer', 
  `contract_type_actual` string COMMENT 'from deserializer', 
  `cpv_at_source` string COMMENT 'from deserializer', 
  `cpvs` array<struct<cpv_code:string>> COMMENT 'from deserializer', 
  `crawled_at` string COMMENT 'from deserializer', 
  `currency` string COMMENT 'from deserializer', 
  `custom_tags` array<struct<tender_custom_tag_company_id:string,tender_custom_tag_description:string,tender_custom_tag_value:string>> COMMENT 'from deserializer', 
  `customer_details` array<struct<contact_person:string,customer_main_activity:string,customer_nuts:string,org_address:string,org_city:string,org_country:string,org_description:string,org_email:string,org_fax:string,org_language:string,org_name:string,org_parent_id:int,org_phone:string,org_state:string,org_type:int,org_website:string,postal_code:string,type_of_authority_code:string>> COMMENT 'from deserializer', 
  `dispatch_date` string COMMENT 'from deserializer', 
  `document_cost` double COMMENT 'from deserializer', 
  `document_fee` string COMMENT 'from deserializer', 
  `document_opening_time` string COMMENT 'from deserializer', 
  `document_purchase_end_time` string COMMENT 'from deserializer', 
  `document_purchase_start_time` string COMMENT 'from deserializer', 
  `document_type_description` string COMMENT 'from deserializer', 
  `earnest_money_deposit` string COMMENT 'from deserializer', 
  `eligibility` string COMMENT 'from deserializer', 
  `est_amount` double COMMENT 'from deserializer', 
  `funding_agencies` array<struct<funding_agency:int>> COMMENT 'from deserializer', 
  `grossbudgeteuro` double COMMENT 'from deserializer', 
  `grossbudgetlc` double COMMENT 'from deserializer', 
  `identifier` string COMMENT 'from deserializer', 
  `is_deadline_assumed` boolean COMMENT 'from deserializer', 
  `is_lot_default` boolean COMMENT 'from deserializer', 
  `is_publish_assumed` boolean COMMENT 'from deserializer', 
  `is_publish_on_gec` boolean COMMENT 'from deserializer', 
  `local_description` string COMMENT 'from deserializer', 
  `local_title` string COMMENT 'from deserializer', 
  `lot_details` array<struct<award_details:array<struct<address:string,award_date:string,award_quantity:double,bid_recieved:string,bidder_country:string,bidder_name:string,contract_duration:string,final_estimated_value:double,grossawardvalueeuro:double,grossawardvaluelc:double,initial_estimated_value:double,netawardvalueeuro:double,netawardvaluelc:double,notes:string,winner_group_name:string>>,contract_duration:string,contract_end_date:string,contract_number:string,contract_start_date:string,contract_type:string,lot_actual_number:string,lot_award_date:string,lot_cancellation_date:string,lot_class_codes_at_source:string,lot_contract_type_actual:string,lot_cpv_at_source:string,lot_cpvs:array<struct<lot_cpv_code:string>>,lot_criteria:array<struct<lot_criteria_title:string,lot_criteria_weight:int,lot_is_price_related:boolean>>,lot_description:string,lot_description_english:string,lot_grossbudget:double,lot_grossbudget_lc:double,lot_is_canceled:boolean,lot_max_quantity:double,lot_min_quantity:double,lot_netbudget:double,lot_netbudget_lc:double,lot_number:int,lot_nuts:string,lot_quantity:double,lot_quantity_uom:string,lot_title:string,lot_title_english:string,lot_vat:double,lot_grossbudgeteuro:double,lot_grossbudgetlc:double>> COMMENT 'from deserializer', 
  `main_language` string COMMENT 'from deserializer', 
  `netbudgeteuro` double COMMENT 'from deserializer', 
  `netbudgetlc` double COMMENT 'from deserializer', 
  `notice_contract_type` string COMMENT 'from deserializer', 
  `notice_deadline` string COMMENT 'from deserializer', 
  `notice_no` string COMMENT 'from deserializer', 
  `notice_summary_english` string COMMENT 'from deserializer', 
  `notice_text` string COMMENT 'from deserializer', 
  `notice_title` string COMMENT 'from deserializer', 
  `notice_type` int COMMENT 'from deserializer', 
  `notice_url` string COMMENT 'from deserializer', 
  `performance_country` array<struct<performance_country:string>> COMMENT 'from deserializer', 
  `performance_state` array<struct<performance_state:string>> COMMENT 'from deserializer', 
  `pre_bid_meeting_date` string COMMENT 'from deserializer', 
  `procurement_method` int COMMENT 'from deserializer', 
  `project_name` string COMMENT 'from deserializer', 
  `publish_date` string COMMENT 'from deserializer', 
  `related_tender_id` string COMMENT 'from deserializer', 
  `source_of_funds` string COMMENT 'from deserializer', 
  `tender_award_date` string COMMENT 'from deserializer', 
  `tender_cancellation_date` string COMMENT 'from deserializer', 
  `tender_contract_end_date` string COMMENT 'from deserializer', 
  `tender_contract_number` string COMMENT 'from deserializer', 
  `tender_contract_start_date` string COMMENT 'from deserializer', 
  `tender_criteria` array<struct<tender_criteria_title:string,tender_criteria_weight:int,tender_is_price_related:boolean>> COMMENT 'from deserializer', 
  `tender_id` string COMMENT 'from deserializer', 
  `tender_is_canceled` boolean COMMENT 'from deserializer', 
  `tender_max_quantity` double COMMENT 'from deserializer', 
  `tender_min_quantity` double COMMENT 'from deserializer', 
  `tender_quantity` string COMMENT 'from deserializer', 
  `tender_quantity_uom` string COMMENT 'from deserializer', 
  `type_of_procedure` string COMMENT 'from deserializer', 
  `type_of_procedure_actual` string COMMENT 'from deserializer', 
  `vat` double COMMENT 'from deserializer', 
  `script_name` string COMMENT 'from deserializer', 
  `procurment_method` int COMMENT 'from deserializer')
PARTITIONED BY ( 
  `year` int COMMENT '', 
  `month` int COMMENT '', 
  `day` int COMMENT '', 
  `country` string COMMENT '')
STORED AS PARQUET
LOCATION
  's3://gec-script-executions/json_import_parquet'
TBLPROPERTIES (
  'parquet.compression'='SNAPPY');

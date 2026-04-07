select * from {{ source("company_src", "FINANCE") }}

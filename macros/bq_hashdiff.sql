
{% macro bq_hashdiff(cols) %}
  TO_HEX(SHA256(CONCAT({{ cols | map('string') | join(", '', ") }})))
{% endmacro %}

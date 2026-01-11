
{% macro bq_hash_key(cols) %}
  TO_HEX(SHA256(CONCAT({{ cols | map('string') | join(", '', ") }})))
{% endmacro %}

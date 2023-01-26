# replace "jrdetorre-bqml-ga4churnpred" with your own project id

CREATE OR REPLACE TABLE `jrdetorre-bqml-ga4churnpred.demo_ga4churnprediction.user_demographics` AS (

  WITH first_values AS (
      SELECT
          user_pseudo_id,
          geo.country as country,
          device.operating_system as operating_system,
          device.language as language,
          ROW_NUMBER() OVER (PARTITION BY user_pseudo_id ORDER BY event_timestamp DESC) AS row_num
      FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
      WHERE event_name="user_engagement"
      )
  SELECT * EXCEPT (row_num)
  FROM first_values
  WHERE row_num = 1
  );
  
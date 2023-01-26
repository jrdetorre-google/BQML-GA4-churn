#replace "jrdetorre-bqml-ga4churnpred" with your own project id

CREATE OR REPLACE TABLE `jrdetorre-bqml-ga4churnpred.demo_ga4churnprediction.returningusers` AS (
    WITH firstlasttouch AS (
    SELECT
      user_pseudo_id,
      TIMESTAMP_MICROS(MIN(event_timestamp)) AS user_first_engagement,
      TIMESTAMP_MICROS(MAX(event_timestamp)) AS user_last_engagement
    FROM
      `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
    WHERE event_name='user_engagement'
    GROUP BY
      user_pseudo_id

  ), data AS (
  SELECT
    user_pseudo_id,
    user_first_engagement,
    user_last_engagement,
    EXTRACT(MONTH from user_first_engagement) as month,
    EXTRACT(DAYOFYEAR from user_first_engagement) as julianday,
    EXTRACT(DAYOFWEEK from user_first_engagement) as dayofweek,

    #add 24 hr to user's first touch
    TIMESTAMP_ADD(user_first_engagement, INTERVAL 24 HOUR) AS ts_24hr_after_first_engagement,

#churned = 1 if last_touch within 24 hr of app installation, else 0
IF (user_last_engagement <  
      TIMESTAMP_ADD(user_first_engagement, 
      INTERVAL 24 HOUR),
    1,
    0 ) AS churned,

#bounced = 1 if last_touch within 10 min, else 0
IF (user_last_engagement <=
      TIMESTAMP_ADD(user_first_engagement, 
      INTERVAL 10 MINUTE),
    1,
    0 ) AS bounced,
  FROM
    firstlasttouch
  GROUP BY
    1,2,3
    )

  SELECT
    user_pseudo_id,
    user_first_engagement,
    user_last_engagement,
    ts_24hr_after_first_engagement,
    month,
    julianday,
    dayofweek,
    churned,
    bounced
  FROM
    data);
    
# replace "jrdetorre-bqml-ga4churnpred" with your own project id

CREATE OR REPLACE TABLE `jrdetorre-bqml-ga4churnpred.demo_ga4churnprediction.user_aggregate_behavior` AS (
    WITH
  events_first24hr AS (
    #select user data only from first 24 hr of using the app
    SELECT
      e.*
    FROM
      `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*` e
    JOIN
      `jrdetorre-bqml-ga4churnpred.demo_ga4churnprediction.returningusers` r
    ON
      e.user_pseudo_id = r.user_pseudo_id
    WHERE
      TIMESTAMP_MICROS(e.event_timestamp) <= r.ts_24hr_after_first_engagement
    )
    SELECT
        user_pseudo_id,
        SUM(IF(event_name = 'user_engagement', 1, 0)) AS cnt_user_engagement,
        SUM(IF(event_name = 'page_view', 1, 0)) AS cnt_page_view,
        SUM(IF(event_name = 'view_item', 1, 0)) AS cnt_view_item,
        SUM(IF(event_name = 'view_promotion', 1, 0)) AS cnt_view_promotion,
        SUM(IF(event_name = 'select_promotion', 1, 0)) AS cnt_select_promotion,
        SUM(IF(event_name = 'add_to_cart', 1, 0)) AS cnt_add_to_cart,
        SUM(IF(event_name = 'begin_checkout', 1, 0)) AS cnt_begin_checkout,
        SUM(IF(event_name = 'add_shipping_info', 1, 0)) AS cnt_add_shipping_info,
        SUM(IF(event_name = 'add_payment_info', 1, 0)) AS cnt_add_payment_info,
        SUM(IF(event_name = 'purchase', 1, 0)) AS cnt_purchase,
    FROM
        events_first24hr
    GROUP BY
        1
    );
    
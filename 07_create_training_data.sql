# replace "jrdetorre-bqml-ga4churnpred" with your own project id

CREATE OR REPLACE TABLE `jrdetorre-bqml-ga4churnpred.demo_ga4churnprediction.training_data` AS (
    
  SELECT
    dem.*,
    IFNULL(beh.cnt_user_engagement, 0) AS cnt_user_engagement,
    IFNULL(beh.cnt_page_view, 0) AS cnt_page_view,
    IFNULL(beh.cnt_view_item, 0) AS cnt_view_item,
    IFNULL(beh.cnt_view_promotion, 0) AS cnt_view_promotion,
    IFNULL(beh.cnt_select_promotion, 0) AS cnt_select_promotion,
    IFNULL(beh.cnt_add_to_cart, 0) AS cnt_add_to_cart,
    IFNULL(beh.cnt_begin_checkout, 0) AS cnt_begin_checkout,
    IFNULL(beh.cnt_add_shipping_info, 0) AS cnt_add_shipping_info,
    IFNULL(beh.cnt_add_payment_info, 0) AS cnt_add_payment_info,
    IFNULL(beh.cnt_purchase, 0) AS cnt_purchase,
    ret.month,
    ret.julianday,
    ret.dayofweek,
    ret.churned
  FROM
    `jrdetorre-bqml-ga4churnpred.demo_ga4churnprediction.returningusers` ret
  LEFT OUTER JOIN
    `jrdetorre-bqml-ga4churnpred.demo_ga4churnprediction.user_demographics` dem
  ON 
    ret.user_pseudo_id = dem.user_pseudo_id
  LEFT OUTER JOIN 
    `jrdetorre-bqml-ga4churnpred.demo_ga4churnprediction.user_aggregate_behavior` beh
  ON
    ret.user_pseudo_id = beh.user_pseudo_id
  WHERE ret.bounced = 0
  );
  
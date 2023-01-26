# replace "jrdetorre-bqml-ga4churnpred" with your own project id

SELECT
  user_pseudo_id,
  churned,
  predicted_churned,
  predicted_churned_probs[OFFSET(0)].prob as probability_churned
  FROM
    ML.PREDICT(MODEL `jrdetorre-bqml-ga4churnpred.demo_ga4churnprediction.model_churn`,
    (SELECT * FROM `jrdetorre-bqml-ga4churnpred.demo_ga4churnprediction.training_data`),
    STRUCT(0.5447 AS threshold)) 
    
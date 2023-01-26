# replace "jrdetorre-bqml-ga4churnpred" with your own project id

SELECT
  *
  FROM
    ML.PREDICT(MODEL `jrdetorre-bqml-ga4churnpred.demo_ga4churnprediction.model_churn`,
    (SELECT * FROM `jrdetorre-bqml-ga4churnpred.demo_ga4churnprediction.training_data`),
    STRUCT(0.5447 AS threshold))
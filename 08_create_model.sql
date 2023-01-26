# replace "jrdetorre-bqml-ga4churnpred" with your own project id

CREATE OR REPLACE MODEL `jrdetorre-bqml-ga4churnpred.demo_ga4churnprediction.model_churn`
    
  OPTIONS(
    MODEL_TYPE="LOGISTIC_REG", #or BOOSTED_TREE_CLASSIFIER, DNN_CLASSIFIER, AUTOML_CLASSIFIER
    INPUT_LABEL_COLS=["churned"]
  ) AS

SELECT
    * EXCEPT(user_pseudo_id)
FROM
    `jrdetorre-bqml-ga4churnpred.demo_ga4churnprediction.training_data`
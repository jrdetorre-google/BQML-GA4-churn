# replace "jrdetorre-bqml-ga4churnpred" with your own project id

# This query will show how many users we have in each class

SELECT
  churned
  , bounced
  , COUNT(user_pseudo_id) as how_many
FROM
  `jrdetorre-bqml-ga4churnpred.demo_ga4churnprediction.returningusers`
GROUP BY
  1,
  2
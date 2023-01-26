# replace "jrdetorre-bqml-ga4churnpred" with your own project id
# This query shows who many events we have of each kind to select the more important ones 

SELECT
    event_name,
    COUNT(event_name) as event_count
FROM
  `firebase-public-project.analytics_153293282.events_*`
GROUP BY 1
ORDER BY
   event_count DESC

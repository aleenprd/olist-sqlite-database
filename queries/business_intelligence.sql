SELECT SUM (frequency)
FROM (
        SELECT product_category_name_english,
            AVG(review_score) AS avg_review_score,
            COUNT(review_score) AS frequency
        FROM (
                /* Which product categories DO people review badly
                 AND what ARE they saying about their order? */
                SELECT t.product_category_name_english,
                    r.review_score,
                    r.review_comment_message
                FROM reviews r
                    JOIN orders o ON o.order_id == r.order_id
                    JOIN items i ON i.order_id == o.order_id
                    JOIN products p ON p.product_id == i.product_id
                    JOIN translation t ON t.product_category_name == p.product_category_name
                WHERE r.review_score < 3
                    AND r.review_comment_message NOT LIKE ""
                ORDER BY product_category_name_english,
                    review_score DESC
            )
        GROUP BY product_category_name_english
        ORDER BY frequency DESC
    );
/*
 *
 */
SELECT product_category_name_english,
    AVG(review_score) AS avg_review_score,
    COUNT(*) AS frequency
FROM (
        /* Which product categories DO people review badly
         AND what ARE they saying about their order? */
        SELECT t.product_category_name_english,
            r.review_score,
            r.review_comment_message
        FROM reviews r
            JOIN orders o ON o.order_id == r.order_id
            JOIN items i ON i.order_id == o.order_id
            JOIN products p ON p.product_id == i.product_id
            JOIN translation t ON t.product_category_name == p.product_category_name
        WHERE r.review_score < 3
            AND r.review_comment_message NOT LIKE ""
        ORDER BY product_category_name_english,
            review_score DESC
    )
GROUP BY product_category_name_english
ORDER BY frequency DESC;
/*
 *
 */
SELECT review_score,
    order_id
FROM reviews
WHERE review_score < 3
    AND review_comment_message NOT LIKE ""
GROUP BY review_score;
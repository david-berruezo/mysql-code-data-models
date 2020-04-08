# replace
UPDATE dynamic_gallery_codigos SET image_1 = REPLACE(image_1, 'http://www.davidberruezoportfolio.net', '') WHERE image_1 LIKE '%http://www.davidberruezoportfolio.net%';


SET SQL_SAFE_UPDATES = 0;

# replace

/*
http://www.example.com/articles/updates/43
http://www.example.com/articles/updates/866
http://www.example.com/articles/updates/323
http://www.example.com/articles/updates/seo-url
http://www.example.com/articles/updates/4?something=test
*/

UPDATE your_table
SET your_field = REPLACE(your_field, 'articles/updates/', 'articles/news/')
WHERE your_field LIKE '%articles/updates/%'

/* http://www.berruezomoda.com/blog/?p=1 */
UPDATE wp_posts
SET guid = REPLACE(guid, 'http://www.berruezomoda.com', 'http://localhost/makeyoursuitbuena/blog/')
WHERE guid LIKE '%http://www.berruezomoda.com%';
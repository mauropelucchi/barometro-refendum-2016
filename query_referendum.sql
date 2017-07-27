## check numero di record
select count(*) from tweet_referendum where tweet_referendum.read = '1'

select count(distinct tweet_id) from tweet_terms


## check record per giorno
select DATE_FORMAT(tweet_referendum.tweet_created_at,'%Y-%m-%d') as tweet_date, count(*) from tweet_referendum where tweet_referendum.read = '1'
GROUP BY DATE_FORMAT(tweet_referendum.tweet_created_at,'%Y-%m-%d')
order by tweet_date desc


select DATE_FORMAT(tweet_referendum.tweet_created_at,'%Y-%m-%d') as tweet_date, count(*) from tweet_referendum
inner join
(
select tweet_id, sum(polarity_org) as polarity from tweet_terms inner join terms_en_polarity
on (tweet_terms.term = terms_en_polarity.word)
group by tweet_id) pol on tweet_referendum.tweet_id = pol.tweet_id
where tweet_referendum.read = '1'
GROUP BY DATE_FORMAT(tweet_referendum.tweet_created_at,'%Y-%m-%d')
order by tweet_date desc

## check termini non ancora tradotti
select count(*) from terms where word not in (
select word from terms_en)

## check termini non ancora polarizzati
SELECT count(*) FROM terms_en where word not in (SELECT word FROM terms_en_polarity);

select count(*) from
(select tweet_id, sum(polarity_org) as polarity from tweet_terms inner join terms_en_polarity
on (tweet_terms.term = terms_en_polarity.word)
group by tweet_id
) corpus where polarity > 0.2

select count(*) from
(select tweet_id, sum(polarity_org) as polarity from tweet_terms inner join terms_en_polarity
on (tweet_terms.term = terms_en_polarity.word)
group by tweet_id
) corpus where polarity < 0.2 and polarity > 0

select count(*) from
(select tweet_id, sum(polarity_org) as polarity from tweet_terms inner join terms_en_polarity
on (tweet_terms.term = terms_en_polarity.word)
group by tweet_id
) corpus where polarity < 0

## creazioni indici
CREATE INDEX term_en_idx ON terms_en_polarity (word)
CREATE INDEX term_tweet_idx ON tweet_terms (tweet_id)

## esportazioni csv
select * from tweet_referendum
inner join
(
select tweet_id, sum(polarity_org) as polarity from tweet_terms inner join terms_en_polarity
on (tweet_terms.term = terms_en_polarity.word)
group by tweet_id) pol on tweet_referendum.tweet_id = pol.tweet_id
where tweet_referendum.read = '1'

select * from tweet_terms

select * from terms_en_polarity


select * from tweet_referendum
inner join
(
select tweet_id, sum(polarity_org) as polarity from tweet_terms inner join terms_en_polarity
on (tweet_terms.term = terms_en_polarity.word)
group by tweet_id) pol on tweet_referendum.tweet_id = pol.tweet_id
where tweet_referendum.read = '1'


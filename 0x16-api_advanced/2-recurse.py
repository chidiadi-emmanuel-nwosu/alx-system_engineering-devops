#!/usr/bin/python3
"""
1-top_ten.py
"""


def recurse(subreddit, hot_list=[], after=None):
    """a function that queries the Reddit API and returns a list
       containing titles of all hot articles for a given subreddit.
    """
    import requests

    url = "https://www.reddit.com/r/{}/hot.json".format(subreddit)
    headers = {'User-Agent': 'Mozilla/5.0', 'allow_redirects': 'False'}
    params = {'limit': 100}
    if after:
        params['after'] = after
    response = requests.get(url, headers=headers, params=params)

    if response.status_code == 200:
        posts = response.json().get('data')
        for post in posts.get('children'):
            hot_list.append(post.get('data', None).get('title', None))

        after = posts.get('after')
        if after:
            return recurse(subreddit, hot_list, after)
        return hot_list
    else:
        return None

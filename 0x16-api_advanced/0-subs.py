#!/usr/bin/python3
"""
0-subs.py
"""


def number_of_subscribers(subreddit):
    """a function that queries the Reddit API and returns the
       number of subscribers (not active users, total subscribers)
       for a given subreddit
    """
    import requests

    url = "https://www.reddit.com/r/{}/about.json".format(subreddit)
    headers = {'User-Agent': 'Mozilla/5.0'}
    response = requests.get(url, headers=headers, allow_redirects=False)

    if response.status_code == 200:
        data = response.json()
        return (data.get("data").get("subscribers"))
        # return int(data.get('subscribers'))

    return 0

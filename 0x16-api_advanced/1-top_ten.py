#!/usr/bin/python3
"""
1-top_ten.py
"""


def top_ten(subreddit):
    """a function that queries the Reddit API and prints the
       titles of the first 10 hot posts listed for a given
       subreddit.
    """
    import requests

    url = "https://www.reddit.com/r/{}/hot.json".format(subreddit)
    headers = {'User-Agent': 'Mozilla/5.0', 'allow_redirects': 'False'}
    params = {'limit': 10}
    response = requests.get(url, headers=headers, params=params)

    if response.status_code == 200:
        posts = response.json().get('data').get('children')
        if len(posts) != 0:
            for post in posts:
                print(post.get('data', None).get('title', None))
        else:
            print(None)
    else:
        print(None)

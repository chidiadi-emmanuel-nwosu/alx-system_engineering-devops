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
    import json

    url = "https://www.reddit.com/r/{}/hot.json".format(subreddit)
    headers = {'User-Agent': 'Mozilla/5.0', 'allow_redirects': 'False'}
    params = {'limit': 10}
    response = requests.get(url, headers=headers, params=params)

    if response.status_code == 200:
        data = response.json()

        # print(len(data['data']))
        # print(json.dumps(data, indent=4))
        for posts in data['data']['children']:
            print(posts.get('data').get('title'))
    else:
        print(None)

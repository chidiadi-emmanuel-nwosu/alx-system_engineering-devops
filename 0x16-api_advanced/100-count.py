#!/usr/bin/python3
"""
100-count.py
"""


def count_words(subreddit, word_list, after=None, count={}):
    """a recursive function that queries the Reddit API,
       parses the title of all hot articles, and prints a
       sorted count of given keywords
    """
    import requests

    url = "https://www.reddit.com/r/{}/hot.json".format(subreddit)
    headers = {'User-Agent': 'Mozilla/5.0', 'allow_redirects': 'False'}
    params = {'limit': 100}
    if after:
        params['after'] = after
    response = requests.get(url, headers=headers, params=params)

    if response.status_code == 200:
        wordList = [item.lower() for item in word_list]

        posts = response.json().get('data')
        for post in posts.get('children'):
            title = post.get('data').get('title').lower().split()

            for keyword in wordList:
                if keyword in title:
                    if keyword in count:
                        count[keyword] += 1
                    else:
                        count[keyword] = 1

        after = posts.get('after')
        if after:
            return count_words(subreddit, word_list, after, count)

        sorted_count = sorted(count.items(), key=lambda x: (-x[1], x[0]))
        for key, value in sorted_count:
            print("{}: {}".format(key, value))
    else:
        return None

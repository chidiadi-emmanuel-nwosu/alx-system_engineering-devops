#!/usr/bin/python3
"""script to export API data in the json format."""
import csv
import json
import requests
from sys import argv, exit


if __name__ == "__main__":

    todo_url = "https://jsonplaceholder.typicode.com/todos"
    users_url = "https://jsonplaceholder.typicode.com/users"
    json_file = "todo_all_employees.json"

    todos = requests.get(todo_url)
    users = requests.get(users_url)

    if todos.status_code != 200 or users.status_code != 200:
        exit(1)

    todos = todos.json()
    users = users.json()

    json_content = {}

    for user in users:
        user_todos = list(filter(lambda x: x['userId'] == user['id'], todos))
        json_content[f"{user['id']}"] = [
            {
                'username': user['username'],
                'task': todo['title'],
                'completed': todo['completed']
            }
            for todo in user_todos
        ]

    with open(json_file, mode="w") as file:
        json.dump(json_content, file)

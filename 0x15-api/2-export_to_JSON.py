#!/usr/bin/python3
"""script to export API data in the json format."""
import csv
import json
import requests
from sys import argv, exit


if __name__ == "__main__":
    try:
        employee_id = int(argv[1])
    except Exception as e:
        print("employee Id missing")
        exit(1)

    todo_url = "https://jsonplaceholder.typicode.com/todos"
    users_url = "https://jsonplaceholder.typicode.com/users"
    json_file = f"{employee_id}.json"

    todos = requests.get(todo_url)
    users = requests.get(users_url)

    if todos.status_code != 200 or users.status_code != 200:
        exit(1)

    todos = todos.json()
    users = users.json()

    todos = list(filter(lambda x: x['userId'] == employee_id, todos))
    employee = list(filter(lambda x: x['id'] == employee_id, users))

    username = employee[0]['username']

    json_content = {}
    json_content[f'{employee_id}'] = [
        {
            'task': todo['title'],
            'completed': todo['completed'],
            'username': username
        }
        for todo in todos
    ]

    with open(json_file, mode="w") as file:
        json.dump(json_content, file)

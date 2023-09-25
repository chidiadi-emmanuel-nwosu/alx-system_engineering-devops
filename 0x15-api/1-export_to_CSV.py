#!/usr/bin/python3
import requests
from sys import argv, exit
import csv


if __name__ == "__main__":
    try:
        employee_id = int(argv[1])
    except Exception as e:
        print("employee Id missing")
        exit(1)

    todo_url = "https://jsonplaceholder.typicode.com/todos"
    users_url = "https://jsonplaceholder.typicode.com/users"
    csv_file = f"{employee_id}.csv"

    todos = requests.get(todo_url)
    users = requests.get(users_url)

    if todos.status_code != 200 or users.status_code != 200:
        exit(1)

    todos = todos.json()
    users = users.json()

    todos = list(filter(lambda x: x['userId'] == employee_id, todos))
    employee = list(filter(lambda x: x['id'] == employee_id, users))

    username = employee[0]['username']
    csv_content = [
        {'id': employee_id,
         'user': username,
         'completed': todo['completed'],
         'title': todo['title']}
        for todo in todos
    ]

    with open(csv_file, mode="w") as file:
        csv_writer = csv.writer(
            file, delimiter=',', quotechar='"', quoting=csv.QUOTE_ALL
        )

        for _ in csv_content:
            csv_writer.writerow(_.values())

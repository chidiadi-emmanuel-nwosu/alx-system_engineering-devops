#!/usr/bin/python3
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

    todos = requests.get(todo_url)
    users = requests.get(users_url)

    if todos.status_code != 200 or users.status_code != 200:
        exit(1)

    todos = todos.json()
    users = users.json()

    todos = list(filter(lambda x: x['userId'] == employee_id, todos))
    jobs_done = list(filter(lambda x: x['completed'], todos))
    employee_name = list(filter(lambda x: x['id'] == employee_id, users))

    print(
        f"Employee {employee_name[0]['name']} is done with"
        f"tasks({len(jobs_done)}/{len(todos)}):"
    )

    for jobs in jobs_done:
        print(f"\t {jobs['title']}")

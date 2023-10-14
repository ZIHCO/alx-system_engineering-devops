#!/usr/bin/python3
"""Write a Python script that, using this REST API,
   https://jsonplaceholder.typicode.com/todos/1,
   for a given employee ID, returns information about
   his/her TODO list progress."""
import requests
from sys import argv

if __name__ == "__main__":
    bio_url = "https://jsonplaceholder.typicode.com/users/" + argv[1]
    todo_url = "https://jsonplaceholder.typicode.com/todos/"
    get_bio = requests.get(bio_url).json()
    get_todo = requests.get(todo_url).json()

    total_tasks = 0
    completed_tasks = 0
    task_list = []
    for item in get_todo:
        if item['userId'] == int(argv[1]):
            total_tasks += 1
            if item['completed']:
                completed_tasks += 1
                task_list.append(item['title'])
    print(get_bio['name'] + ' is done with tasks(' + str(completed_tasks) +
          '/' + str(total_tasks) + '):')
    for task in task_list:
        print('\t ' + task)

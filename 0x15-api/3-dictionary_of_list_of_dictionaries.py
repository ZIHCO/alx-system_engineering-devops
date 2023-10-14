#!/usr/bin/python3
"""Write a Python script that, using this REST API,
   https://jsonplaceholder.typicode.com/todos/1,
   for a given employee ID, returns information about
   his/her TODO list progress.
   Save in csv in USER_ID.json"""
import json
import requests

if __name__ == "__main__":
    users_url = "https://jsonplaceholder.typicode.com/users/"
    todo_url = "https://jsonplaceholder.typicode.com/todos/"
    users_bio = requests.get(users_url).json()
    get_todo = requests.get(todo_url).json()

    filename = 'todo_all_employees.json'
    with open(filename, 'a', encoding='UTF-8') as f:
        user_dict = {}
        for user in users_bio:
            user_list = []
            for item in get_todo:
                if item['userId'] == user['id']:
                    item_dict = {}
                    item_dict['task'] = item['title']
                    item_dict['completed'] = item['completed']
                    item_dict['username'] = user['username']
                    user_list.append(item_dict)
            user_dict[user['id']] = user_list
        f.write(json.dumps(user_dict))

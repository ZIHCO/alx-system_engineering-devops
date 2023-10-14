#!/usr/bin/python3
"""Write a Python script that, using this REST API,
   https://jsonplaceholder.typicode.com/todos/1,
   for a given employee ID, returns information about
   his/her TODO list progress.
   Save in csv in USER_ID.csv"""
import requests
from sys import argv

if __name__ == "__main__":
    bio_url = "https://jsonplaceholder.typicode.com/users/" + argv[1]
    todo_url = "https://jsonplaceholder.typicode.com/todos/"
    get_bio = requests.get(bio_url).json()
    get_todo = requests.get(todo_url).json()

    with open((argv[1] + '.csv'), 'a', encoding='UTF-8') as f:
        for item in get_todo:
            if item['userId'] == int(argv[1]):
                text = '\"' + str(item['userId']) + '\",\"'\
                       + get_bio['username'] + '\",\"'\
                       + str(item['completed']) + '\",\"'\
                       + item['title'] + '\"\n'
                f.write(text)

#Listy
python_topics = [[1,"variables"], [2,"control flow"], [3,"loops"], [4,"modules"], [5,"classes"]]
modified = list(zip(*python_topics))
print(modified)

python_topics_index = []
index = 0
while index < len(python_topics):
    python_topics_index.append(python_topics[index][0])
    index += 1
print("Lista z indexami: ",python_topics_index)

python_topics_topic = []
index = 0
while index < len(python_topics):
    python_topics_topic.append(python_topics[index][1])
    index += 1
print("Lista z tematami: ",python_topics_topic)
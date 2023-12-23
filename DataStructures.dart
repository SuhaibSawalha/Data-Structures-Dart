import 'dart:io';

class Stack<E> {
  Stack() : _storage = <E>[];
  final List<E> _storage;

  void push(E element) => _storage.add(element);

  E pop() => _storage.removeLast();

  bool get isEmpty => _storage.isEmpty;
}

void printListInReverse(final list) {
  final stack = Stack();
  for (final element in list) {
    stack.push(element);
  }
  stdout.write("Reversed list: [");
  while (!stack.isEmpty) {
    stdout.write("${stack.pop()}");
    if (!stack.isEmpty) {
      stdout.write(", ");
    }
  }
  stdout.write("]\n");
}

bool BalancedParentheses(final String input) {
  final stack = Stack();
  for (final char in input.split('')) {
    if (char == '(') {
      stack.push(char);
    } else {
      if (stack.isEmpty) {
        return false;
      }
      stack.pop();
    }
  }
  return stack.isEmpty;
}

class Node<T> {
  Node({required this.value, this.next});
  T value;
  Node<T>? next;
}

class LinkedList<E> {
  Node<E>? head;
  Node<E>? tail;

  bool get isEmpty => head == null;

  void push(E value) {
    head = Node(value: value, next: head);
    tail ??= head;
  }

  void append(E value) {
    if (isEmpty) {
      push(value);
      return;
    }
    tail!.next = Node(value: value);
    tail = tail!.next;
  }

  Node<E>? nodeAt(int index) {
    var currentNode = head;
    var currentIndex = 0;
    while (currentNode != null && currentIndex < index) {
      currentNode = currentNode.next;
      currentIndex += 1;
    }
    return currentNode;
  }

  Node<E> insertAfter(Node<E> node, E value) {
    if (tail == node) {
      append(value);
      return tail!;
    }
    node.next = Node(value: value, next: node.next);
    return node.next!;
  }

  E? pop() {
    final value = head?.value;
    head = head?.next;
    if (isEmpty) {
      tail = null;
    }
    return value;
  }

  E? removeLast() {
    if (head?.next == null) return pop();
    var current = head;
    while (current!.next != tail) {
      current = current.next;
    }
    final value = tail?.value;
    tail = current;
    tail?.next = null;
    return value;
  }

  E? removeAfter(Node<E> node) {
    final value = node.next?.value;
    if (node.next == tail) {
      tail = node;
    }
    node.next = node.next?.next;
    return value;
  }

  List<E> toListValue() {
    final list = <E>[];
    var current = head;
    while (current != null) {
      list.add(current.value);
      current = current.next;
    }
    return list;
  }

  List<Node> toListNode() {
    final list = <Node>[];
    var current = head;
    while (current != null) {
      list.add(current);
      current = current.next;
    }
    return list;
  }

  int length() {
    var current = head;
    var count = 0;
    while (current != null) {
      count++;
      current = current.next;
    }
    return count;
  }

  void reverse() {
    Node<E>? prev = null;
    Node<E>? current = head;
    Node<E>? next = null;
    tail = head;
    while (current != null) {
      next = current.next;
      current.next = prev;
      prev = current;
      current = next;
    }
    head = prev;
  }

  void removeOccurrences(E value) {
    var current = head;
    while (current != null && current.next != null) {
      if (current.next!.value == value) {
        current.next = current.next!.next;
      } else {
        current = current.next;
      }
    }
    if (head!.value == value) {
      head = head!.next;
    }
  }
}

void printLinkedListInReverse(final linkedList) {
  final reversedLinkedList = LinkedList();
  final list = linkedList.toListValue();
  for (final element in list) {
    reversedLinkedList.push(element);
  }
  print("Reversed list: ${reversedLinkedList.toListValue()}");
}

Node findMiddleNodeOfLinkedList(final linkedList) {
  return linkedList.nodeAt(linkedList.length() ~/ 2)!;
}

void main() {
  printListInReverse([1, 2, 3, 4]);
  print(
      "((())(())) is ${BalancedParentheses("((())(()))") ? "" : "not"} balanced");

  print(
      "((())(()))) is ${BalancedParentheses("((())(())))") ? "" : "not"} balanced");
  final linkedList = LinkedList<int>();
  linkedList.append(1);
  linkedList.append(2);
  linkedList.append(3);
  printLinkedListInReverse(linkedList);
  print(findMiddleNodeOfLinkedList(linkedList).value);
  print("Before reverse: ${linkedList.toListValue()}");
  linkedList.reverse();
  print("After reverse: ${linkedList.toListValue()}");
  linkedList.append(1);
  linkedList.append(2);
  linkedList.append(2);
  linkedList.append(3);
  print("Before remove: ${linkedList.toListValue()}");
  linkedList.removeOccurrences(2);
  print("After remove: ${linkedList.toListValue()}");
}

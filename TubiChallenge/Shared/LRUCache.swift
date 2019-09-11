//
//  LRUCache.swift
//  TubiChallenge
//
//  Created by Matthew Pileggi on 9/10/19.
//  Copyright © 2019 Matthew Pileggi. All rights reserved.
//

import Foundation

class Node<T: Hashable, V> {
    
    let key: T
    var value: V
    var previous: Node<T, V>?
    var next: Node<T, V>?
    
    init(key: T, value: V) {
        self.key = key
        self.value = value
    }
    
}


class LRUCache<T: Hashable, V> {
    
    private var count = 0
    private let capacity: Int
    private var cache = [T: Node<T, V>]()
    
    private var head: Node<T, V>? //Least recently used
    private var tail: Node<T, V>? //Most recently used
    
    init(capacity: Int) {
        self.capacity = capacity
    }
    
    func add(object: V, withKey key: T) {
        if cache[key] != nil {
            //remove object from cache and add with new value
            _removeObject(withKey: key)
            _add(object: object, withKey: key)
        } else if count == capacity, let head = head {
            //remove least recently used if at capacity
            _removeObject(withKey: head.key)
            _add(object: object, withKey: key)
        } else {
            //otherwise just add
            _add(object: object, withKey: key)
        }
        printDetails()
    }
    
    func getObject(forKey key: T) -> V? {
        if let object = cache[key] {
            _removeObject(withKey: key)
            _add(object: object.value, withKey: key)
            printDetails()
            return object.value
        }
        return nil
    }
    
    func isValid(forKey key: T) -> Bool {
        return cache[key] != nil
    }
    
    private func _add(object: V, withKey key: T) {
        //add new object to cache and append to tail
        let newNode = Node(key: key, value: object)
        if head == nil {
            head = newNode
        }
        let oldTail = tail
        tail = newNode
        tail?.previous = oldTail
        oldTail?.next = tail
        
        cache[key] = newNode
        count += 1
    }
    
    private func _removeObject(withKey key: T) {
        if let cachedItem = cache[key] {
            if head?.key == key {
                head = head?.next
            }
            if tail?.key == key {
                tail = tail?.previous
            }
            
            cachedItem.previous?.next = cachedItem.next
            cachedItem.next?.previous = cachedItem.previous
            cache[key] = nil
            count -= 1
        }
    }
    
    private func printDetails() {
        print("CACHE")
        cache.forEach {
            print("\($0), \($1.value)")
        }
        
        print("QUEUE")
        var currentNode = head
        while(currentNode != nil) {
            print("\(currentNode!.key), \(currentNode!.value)")
            currentNode = currentNode?.next
        }
    }
}


<p align="center"><b>МОНУ НТУУ КПІ ім. Ігоря Сікорського ФПМ СПіСКС</b></p>
<p align="center">
<b>Звіт з лабораторної роботи 3</b><br/>
"Конструктивний і деструктивний підходи до роботи зі списками"<br/>
з дисципліни "Вступ до функціонального програмування"
</p>
<p align="right"><b>Студент</b>: Рибалка Денис Віталійович КВ-11</p>
<p align="right"><b>Рік</b>: 2024</p>

## Загальне завдання

Реалізуйте алгоритм сортування чисел у списку двома способами: функціонально і
імперативно.

## Варіант 5 (21)

Алгоритм сортування обміном №2 (із використанням прапорця) за незменшенням.
   
## Лістинг функції з використанням конструктивного підходу:
```lisp
(defun bubble-sort-single-pass (list)
  ;; Якщо список містить один або менше елементів, він уже відсортований
  (if (null (cdr list))
      list
      ;; Порівнюємо перший і другий елементи списку
      (let ((updated-list
             (if (> (car list) (cadr list)) 
                 ;; Якщо перший елемент більший за другий, міняємо їх місцями
                 (cons (cadr list)
                       (bubble-sort-functional (cons (car list) (cddr list))))
                 ;; Інакше залишаємо елементи як є
                 (cons (car list)
                       (bubble-sort-functional (cdr list))))))
        ;; Перевіряємо, чи змінився список після проходу
        (if (equal updated-list list)
            (values updated-list nil) ;; Якщо не змінився, повертаємо nil (немає змін)
            (values updated-list t))))) ;; Якщо змінився, повертаємо t (є зміни)

(defun bubble-sort-functional (list &optional (changes t))
  ;; Якщо змін не було, повертаємо поточний список (вже відсортований)
  (if changes
      ;; Викликаємо bubble-sort-single-pass для виконання однієї ітерації
      (multiple-value-bind (new-list has-changes) (bubble-sort-single-pass list)
        ;; Рекурсивно викликаємо bubble-sort-functional, поки є зміни
        (bubble-sort-functional new-list has-changes))
      list)) ;; Якщо змін не було, повертаємо остаточний список
```

## Лістинг реалізації тестових наборів
```lisp
(defun run-tests ()
  (format t "~%Constructive approach sort:~%")
  (let ((test-cases '((7 1 5 3 9)         
                      ()                  
                      (42)                
                      (0 1 2 3 4 5)      
                      (10 9 8 7 6)        
                      (4 4 4 4 4)         
                      (8 6 7 7 6 8 5)     
                      (-1 5 3 -3 0 2)     
                      (100 -100 0 -1 1)   
                      (15 0 -15 20 -20)   
                      (1000 500 100 10)))) 
    ;; Проганяємо всі тест-кейси
    (dolist (test test-cases)
      (let ((result (bubble-sort-functional test)))
        (format t "Input: ~A~%" test)
        (format t "Result: ~A~%" result)
        ;; Перевірка правильності сортування
        (if (equal result (sort test #'<))
            (format t "Test Passed~%")
            (format t "Test Failed~%"))))))
            
(run-tests)
```

## Результат виконання тестових наборів
```c
Constructive approach sort:
Input: (7 1 5 3 9)
Result: (1 3 5 7 9)
Test Passed
Input: NIL
Result: NIL
Test Passed
Input: (42)
Result: (42)
Test Passed
Input: (0 1 2 3 4 5)
Result: (0 1 2 3 4 5)
Test Passed
Input: (10 9 8 7 6)
Result: (6 7 8 9 10)
Test Passed
Input: (4 4 4 4 4)
Result: (4 4 4 4 4)
Test Passed
Input: (8 6 7 7 6 8 5)
Result: (5 6 6 7 7 8 8)
Test Passed
Input: (-1 5 3 -3 0 2)
Result: (-3 -1 0 2 3 5)
Test Passed
Input: (100 -100 0 -1 1)
Result: (-100 -1 0 1 100)
Test Passed
Input: (15 0 -15 20 -20)
Result: (-20 -15 0 15 20)
Test Passed
Input: (1000 500 100 10)
Result: (10 100 500 1000)
Test Passed
```

					 
## Лістинг функції з використанням деструктивного підходу:
```lisp
(defun bubble-sort-imperative (list)
  (let ((sorted-list (copy-list list))  ;; Копія початкового списку
         (remaining-length (1- (length list)))  ;; Початкова довжина для проходу
         (has-swaps t))  ;; Флаг наявності змін
    (loop while has-swaps do
          (setf has-swaps nil)  ;; Припускаємо, що змін не буде
          (dotimes (index remaining-length)
            (when (> (nth index sorted-list) (nth (+ index 1) sorted-list))  ;; Якщо елементи потрібно поміняти місцями
              (rotatef (nth index sorted-list) (nth (+ index 1) sorted-list))  ;; Міняємо місцями елементи
              (setf has-swaps t)))  ;; Якщо були зміни, встановлюємо флаг
          (setf remaining-length (1- remaining-length)))  ;; Зменшуємо лічильник для наступного проходу
    sorted-list))  ;; Повертаємо відсортований список
```

## Лістинг реалізації тестових наборів
```lisp
(defun run-tests ()
  (format t "~%Destructive approach sort:~%")
  (let ((test-cases '((7 1 5 3 9)         
                      ()                  
                      (42)                
                      (0 1 2 3 4 5)      
                      (10 9 8 7 6)        
                      (4 4 4 4 4)         
                      (8 6 7 7 6 8 5)     
                      (-1 5 3 -3 0 2)     
                      (100 -100 0 -1 1)   
                      (15 0 -15 20 -20)   
                      (1000 500 100 10)))) 
    ;; Проганяємо всі тест-кейси
    (dolist (test test-cases)
      (let ((result (bubble-sort-imperative test)))
        (format t "Input: ~A~%" test)
        (format t "Result: ~A~%" result)
        ;; Перевірка правильності сортування
        (if (equal result (sort test #'<))
            (format t "Test Passed~%")
            (format t "Test Failed~%"))))))
            
(run-tests)
```

## Результат виконання тестових наборів

```c
Destructive approach sort:
Input: (7 1 5 3 9)
Result: (1 3 5 7 9)
Test Passed
Input: NIL
Result: NIL
Test Passed
Input: (42)
Result: (42)
Test Passed
Input: (0 1 2 3 4 5)
Result: (0 1 2 3 4 5)
Test Passed
Input: (10 9 8 7 6)
Result: (6 7 8 9 10)
Test Passed
Input: (4 4 4 4 4)
Result: (4 4 4 4 4)
Test Passed
Input: (8 6 7 7 6 8 5)
Result: (5 6 6 7 7 8 8)
Test Passed
Input: (-1 5 3 -3 0 2)
Result: (-3 -1 0 2 3 5)
Test Passed
Input: (100 -100 0 -1 1)
Result: (-100 -1 0 1 100)
Test Passed
Input: (15 0 -15 20 -20)
Result: (-20 -15 0 15 20)
Test Passed
Input: (1000 500 100 10)
Result: (10 100 500 1000)
Test Passed
```


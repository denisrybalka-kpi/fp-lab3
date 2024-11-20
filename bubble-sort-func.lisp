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

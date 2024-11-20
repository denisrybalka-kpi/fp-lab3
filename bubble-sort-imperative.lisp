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

;;;; Class: CSC 472: Computer Architecture
;;;; Project 1: Mips Dissassembler


;;------------------------------------------------------------------------------
;; Constants

;; OPCODES
(defconstant +opcode-slt+ #b101010)
(defconstant +opcode-lw+ #b100011)
(defconstant +opcode-sw+ #b101011)
(defconstant +opcode-beq+ #b000100)
(defconstant +opcode-bne+ #b000101)

;; FUNCTION CODES
(defconstant +function-code-add+ #b100000)
(defconstant +function-code-sub+ #b100010)
(defconstant +function-code-and+ #b100100)
(defconstant +function-code-or+ #b100101)

;; BITMASKS
(defconstant +bitmask-opcode+ #xFC000000)
(defconstant +bitmask-srcreg-1+ #x03E00000)
(defconstant +bitmask-srcreg-2+ #x001F0000 )
(defconstant +bitmask-destination-reg+ #x0000F800 )
(defconstant +bitmask-function+ #x0000003F )
(defconstant +bitmask-offset+ #x0000FFFF)

;; SHIFTS
;; Since function is already in least sig. bit position. No shift needed
(defconstant +shift-opcode+ 26 )
(defconstant +shift-srcreg1+ 21 )
(defconstant +shift-srcreg2+ 16)
(defconstant +shift-destination-reg+ 11)


;; Use for opcode, s1/2reg's
(defun extract-bits (hex-value bitmask shift)
  "Bitwise &'s the hex-value and bitmask, then shifts right"
  (ash (logand hex-value bitmask) shift))

(defun make-neg (x)
  (- (abs x)))

;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(defun :bits (value &optional (size 16))
  (format t "~v,'0B" size value))
;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

;; Use to extract function code
(defun extract-func (hex-value bitmask)
  "Bitwise &'s the hex-value and bitmask, then shifts right"
  (logand hex-value bitmask))

(defun choose-RI-poison (hex-command)
  "Chooses R-type or I-Type Instruction"
  (let (current-opcode
	(extract-func (hex-command bitmask-opcode)))
    (if (current-opcode = 0)
	(decode-r (hex-command))
	(decode-I (hex-command))))

;;(format t "shift-opcode, in hex, is: ~x" +shift-opcode+)
;; determine opcode, s1, s2
;; function code and offset in temp variables
;; if 0, do R
;; else, do I

;;;  0x02697824 Large Offset

;; NOTES
;;------------------------------------------------------------------------------
;; To Clear Slime REPL, use C-c M-o
;;------------------------------------------------------------------------------
;; Testers	      
;; |-----------------+-------------|
;; | Instruction     | Hexidecimal |
;; |-----------------+-------------|
;; | add $7, $5, $6  | 0x00A63820  |
;; | lw $7, 4($8)    | 0x8D070004  |
;; | sw $23, -4($27) | 0xAF77FFFC  |
;; |-----------------+-------------|
;;------------------------------------------------------------------------------
;; use ASH to shift bits
;; takes 2 args (interger to be shifted, shift count)
;; positive is left shift
;; negative is right shift
;;------------------------------------------------------------------------------



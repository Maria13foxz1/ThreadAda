with Ada.Text_IO;

procedure Threadada is

   can_stop : boolean := false;
   pragma Atomic(can_stop);
   pragma Volatile(can_stop);

   task type break_thread;

   task type main_thread is
      entry start(Thread_ID : Positive; Step : Integer);
   end main_thread;


   task body break_thread is
   begin
      delay 10.0;
      can_stop := true;
   end break_thread;

   task body main_thread is
      sum : Long_Long_Integer := 0;
      count: Long_Long_Integer:=0;
      Thread_ID : Positive;
      Step : Integer;
   begin

         accept start(Thread_ID : in Positive; Step :in Integer) do
            main_thread.thread_id := Thread_ID;
            main_thread.step := step;
      end start;


      loop
         sum := sum + Long_Long_Integer(step);
         count:= count+1;
         exit when can_stop;
      end loop;
      --delay 1.0;

      Ada.Text_IO.Put_Line("Thread N" & Thread_ID'Img & " Sum: " & Sum'Img & " Count: " & Count'Img);
   end main_thread;

      b1 : break_thread;
   --t1 : main_thread;
   --t2 : main_thread;
   --t3 : main_thread;
   --t4 : main_thread;

   Num_Threads:Integer:=6;

   workers : array (1..Num_Threads) of main_thread;

begin
   for I in 1 .. Num_Threads loop
      workers(i).start(Thread_ID => i,
                       Step      => 3);

   end loop;
end Threadada;

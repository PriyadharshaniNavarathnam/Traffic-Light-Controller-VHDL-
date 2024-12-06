library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TrafficLightController is
  port (
    clk: in std_logic;
    reset: in std_logic;
    hospital_vehicles: in std_logic;
    pedestrians_waiting: in std_logic;
    traffic_light: out std_logic_vector(2 downto 0);
    pedestrian_crossing: out std_logic
  );
end TrafficLightController;

architecture Behavioral of TrafficLightController is
  type State is (Green, Yellow, Red, AllowPedestrians, Priority);
  signal current_state, next_state: State;
  signal timer_count: unsigned(23 downto 0);
  constant YELLOW_TIME: unsigned(23 downto 0) := to_unsigned(3000000, 24); -- 3 seconds
  constant PEDESTRIAN_TIME: unsigned(23 downto 0) := to_unsigned(20000000, 24); -- 20 seconds
  
  signal pedestrian_stop: std_logic; -- Signal to prevent pedestrians from crossing
  
begin

  -- Traffic Light Controller FSM process
  process (clk, reset)
  begin
    if reset = '1' then
      current_state <= Green;
      timer_count <= (others => '0');
    elsif rising_edge(clk) then
      current_state <= next_state;
      case current_state is
        when Green =>
          if hospital_vehicles = '1' then
            next_state <= Yellow;
            timer_count <= (others => '0');
          else
            next_state <= Green;
          end if;
          
        when Yellow =>
          if timer_count < YELLOW_TIME then
            next_state <= Yellow;
            timer_count <= timer_count + 1;
          else
            next_state <= Red;
            timer_count <= (others => '0');
          end if;
          
        when Red =>
          if hospital_vehicles = '0' then
            next_state <= Green;
            pedestrian_stop <= '0'; -- Allow pedestrians to cross when the light turns green
          elsif pedestrians_waiting = '1' and timer_count < PEDESTRIAN_TIME then
            next_state <= Red;
            pedestrian_stop <= '1'; -- Prevent pedestrians from crossing when the light is red
            timer_count <= timer_count + 1;
          else
            next_state <= Red;
            pedestrian_stop <= '0'; -- Allow pedestrians to cross when the light turns green
            timer_count <= (others => '0');
          end if;
          
        when Priority =>
          if hospital_vehicles = '0' then
            next_state <= Green;
          else
            next_state <= Priority;
          end if;
          
        when AllowPedestrians =>
          if pedestrians_waiting = '0' then
            next_state <= Green;
          else
            next_state <= AllowPedestrians;
          end if;
          
        when others =>
          next_state <= Green;
      end case;
    end if;
  end process;

  -- Assign output signals based on the current state and pedestrian_stop signal
  process (current_state)
  begin
    case current_state is
      when Green =>
        traffic_light <= "001";
        pedestrian_crossing <= '0';
      when Yellow =>
        traffic_light <= "010";
        pedestrian_crossing <= '0';
      when Red =>
        traffic_light <= "100";
        pedestrian_crossing <= pedestrian_stop; -- Control pedestrian crossing based on pedestrian_stop signal
      when Priority =>
        traffic_light <= "100";
        pedestrian_crossing <= '0'; -- Do not allow pedestrians to cross in the Priority state
           when AllowPedestrians =>
        traffic_light <= "100";
        pedestrian_crossing <= '1'; -- Allow pedestrians to cross in the AllowPedestrians state
      when others =>
        traffic_light <= "000"; -- Default state
        pedestrian_crossing <= '0';
    end case;
  end process;

end Behavioral;

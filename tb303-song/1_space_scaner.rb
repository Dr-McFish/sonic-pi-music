use_synth :tb303

with_fx :reverb, room: 1 do
  live_loop :space_scanner do
    play :e2, cutoff: 95, release: 7, attack: 1,
      cutoff_attack: 4, cutoff_release: 4, amp: 0.75, res: 0.7
    sleep 7.5
    sync "/live_loop/drums"
  end
  
end
function fig = plot_specs_bpf(w_s1, w_p1, w_p2, w_s2, Rs_dB, Rp_dB, h_dB, w)
%PLOT_SPECS_BPF Plots a bandpass filter and its requirements on a new figure
%   Plots the magnitude response of a bandpass filter on a new figure.
%   Then plots red dotted lines to represent the filter specifications for
%   manual comparison of the filter performance against its requirements

    fig = figure;

    % Find the index of the midpoint of the passband
    w_p_mid_idx = find(abs(w-(w_p1+w_p2)/2) < 5e-3);
    w_p_mid_idx = w_p_mid_idx(1); % <-- select the first result if multiple are returned

    % normalize the magnitude response so that the midpoint of the pass
    % band is 0 dB
    h_dB = h_dB - h_dB(w_p_mid_idx);
    h_norm_dB = h_dB(w_p_mid_idx);
    
    % Plot the magnitude response
    plot([0:1:(size(h_dB,1)-1)].*1/size(h_dB,1), h_dB);
    xlim([0 1]);
    xticks([0:1/4:1]);
    xlabel("Normalized Frequency (x \pi rad/sample)");
    ylabel("Magnitude (dB)");
    grid("minor");
    
    % Draw a line representing the normalized magnitude of the passband
    passband_line = annotation(fig, 'line', xapf([w_s1/pi w_s2/pi],gca().Position,xlim), yapf([h_norm_dB h_norm_dB],gca().Position,ylim));
    passband_line.Color = "red";
    passband_line.LineStyle = "--";
    
    % Draw two lines to represent the boundaries of the left transition
    % band
    stopband_rej_left = annotation(fig, 'line', xapf([0 w_p1/pi],gca().Position,xlim), yapf([(h_norm_dB-Rs_dB) (h_norm_dB-Rs_dB)],gca().Position,ylim));
    stopband_rej_left.Color = "red";
    stopband_rej_left.LineStyle = "--";
    
    stopband_rej_right = annotation(fig, 'line', xapf([w_p1/pi 1],gca().Position,xlim), yapf([(h_norm_dB-Rs_dB) (h_norm_dB-Rs_dB)],gca().Position,ylim));
    stopband_rej_right.Color = "red";
    stopband_rej_right.LineStyle = "--";
    
    % Find the coordinates of the transition bands
    transband1_begin = xapf(w_s1/pi,gca().Position,xlim);
    transband1_end = xapf(w_p1/pi,gca().Position,xlim);
    transband2_begin = xapf(w_p2/pi,gca().Position,xlim);
    transband2_end = xapf(w_s2/pi,gca().Position,xlim);
    transband_top = yapf(h_norm_dB,gca().Position,ylim);
    transband_bottom = yapf(h_norm_dB-Rs_dB,gca().Position,ylim);
    
    trans_band_left = annotation(fig, 'rectangle', [transband1_begin transband_bottom (transband1_end-transband1_begin) (transband_top-transband_bottom)],'Color','red','LineStyle','--');
    trans_band_right = annotation(fig, 'rectangle', [transband2_begin transband_bottom (transband2_end-transband2_begin) (transband_top-transband_bottom)],'Color','red','LineStyle','--');

    pass_low = xapf(w_p1/pi,gca().Position,xlim);
    pass_high = xapf(w_p2/pi,gca().Position,xlim);
    ripple_low = yapf((h_norm_dB - Rp_dB),gca().Position,ylim);
    ripple_high = yapf((h_norm_dB + Rp_dB),gca().Position,ylim);
    pass_width = pass_high - pass_low;
    ripple_width = ripple_high - ripple_low;
    pass_rectangle = annotation(fig, 'rectangle', [pass_low ripple_low pass_width ripple_width],'Color','red');
    pass_rectangle.Color = "red";

end
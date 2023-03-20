local _local_1_ = require("leap.util")
local inc = _local_1_["inc"]
local dec = _local_1_["dec"]
local replace_keycodes = _local_1_["replace-keycodes"]
local get_cursor_pos = _local_1_["get-cursor-pos"]
local push_cursor_21 = _local_1_["push-cursor!"]
local get_char_at = _local_1_["get-char-at"]
local __3erepresentative_char = _local_1_["->representative-char"]
local api = vim.api
local empty_3f = vim.tbl_isempty
local _local_2_ = math
local abs = _local_2_["abs"]
local pow = _local_2_["pow"]
local function get_horizontal_bounds()
  local textoff = vim.fn.getwininfo(vim.fn.win_getid())[1].textoff
  local offset_in_win = dec(vim.fn.wincol())
  local offset_in_editable_win = (offset_in_win - textoff)
  local left_bound = (vim.fn.virtcol(".") - offset_in_editable_win)
  local window_width = api.nvim_win_get_width(0)
  local right_bound = (left_bound + dec((window_width - textoff)))
  return {left_bound, right_bound}
end
local function skip_one_21(backward_3f)
  local new_line
  local function _3_()
    if backward_3f then
      return "bwd"
    else
      return "fwd"
    end
  end
  new_line = push_cursor_21(_3_())
  if (new_line == 0) then
    return "dead-end"
  else
    return nil
  end
end
local function to_closed_fold_edge_21(backward_3f)
  local edge_line
  local _5_
  if backward_3f then
    _5_ = vim.fn.foldclosed
  else
    _5_ = vim.fn.foldclosedend
  end
  edge_line = _5_(vim.fn.line("."))
  vim.fn.cursor(edge_line, 0)
  local edge_col
  if backward_3f then
    edge_col = 1
  else
    edge_col = vim.fn.col("$")
  end
  return vim.fn.cursor(0, edge_col)
end
local function to_next_in_window_pos_21(backward_3f, left_bound, right_bound, stopline)
  local forward_3f = not backward_3f
  local _let_8_ = {vim.fn.line("."), vim.fn.virtcol(".")}
  local line = _let_8_[1]
  local virtcol = _let_8_[2]
  local left_off_3f = (virtcol < left_bound)
  local right_off_3f = (virtcol > right_bound)
  local _9_
  if (left_off_3f and backward_3f) then
    _9_ = {dec(line), right_bound}
  elseif (left_off_3f and forward_3f) then
    _9_ = {line, left_bound}
  elseif (right_off_3f and backward_3f) then
    _9_ = {line, right_bound}
  elseif (right_off_3f and forward_3f) then
    _9_ = {inc(line), left_bound}
  else
    _9_ = nil
  end
  if ((_G.type(_9_) == "table") and (nil ~= (_9_)[1]) and (nil ~= (_9_)[2])) then
    local line_2a = (_9_)[1]
    local virtcol_2a = (_9_)[2]
    if (((line == line_2a) and (virtcol == virtcol_2a)) or (backward_3f and (line_2a < stopline)) or (forward_3f and (line_2a > stopline))) then
      return "dead-end"
    else
      vim.fn.cursor({line_2a, virtcol_2a})
      if backward_3f then
        while ((vim.fn.virtcol(".") < right_bound) and not (vim.fn.col(".") >= dec(vim.fn.col("$")))) do
          vim.cmd("norm! l")
        end
        return nil
      else
        return nil
      end
    end
  else
    return nil
  end
end
local function get_match_positions(pattern, _14_, _16_)
  local _arg_15_ = _14_
  local left_bound = _arg_15_[1]
  local right_bound = _arg_15_[2]
  local _arg_17_ = _16_
  local backward_3f = _arg_17_["backward?"]
  local whole_window_3f = _arg_17_["whole-window?"]
  local skip_curpos_3f = _arg_17_["skip-curpos?"]
  local skip_orig_curpos_3f = skip_curpos_3f
  local _let_18_ = get_cursor_pos()
  local orig_curline = _let_18_[1]
  local orig_curcol = _let_18_[2]
  local wintop = vim.fn.line("w0")
  local winbot = vim.fn.line("w$")
  local stopline
  if backward_3f then
    stopline = wintop
  else
    stopline = winbot
  end
  local saved_view = vim.fn.winsaveview()
  local saved_cpo = vim.o.cpo
  local cleanup
  local function _20_()
    vim.fn.winrestview(saved_view)
    vim.o.cpo = saved_cpo
    return nil
  end
  cleanup = _20_
  vim.o.cpo = (vim.o.cpo):gsub("c", "")
  local match_count = 0
  local moved_to_topleft_3f
  if whole_window_3f then
    vim.fn.cursor({wintop, left_bound})
    moved_to_topleft_3f = true
  else
    moved_to_topleft_3f = nil
  end
  local function iter(match_at_curpos_3f)
    local match_at_curpos_3f0 = (match_at_curpos_3f or moved_to_topleft_3f)
    local flags
    local function _22_()
      if backward_3f then
        return "b"
      else
        return ""
      end
    end
    local function _23_()
      if match_at_curpos_3f0 then
        return "c"
      else
        return ""
      end
    end
    flags = (_22_() .. _23_())
    moved_to_topleft_3f = false
    local _24_ = vim.fn.searchpos(pattern, flags, stopline)
    if ((_G.type(_24_) == "table") and (nil ~= (_24_)[1]) and (nil ~= (_24_)[2])) then
      local line = (_24_)[1]
      local col = (_24_)[2]
      local pos = _24_
      if (line == 0) then
        return cleanup()
      elseif ((line == orig_curline) and (col == orig_curcol) and skip_orig_curpos_3f) then
        local _25_ = skip_one_21()
        if (_25_ == "dead-end") then
          return cleanup()
        elseif true then
          local _ = _25_
          return iter(true)
        else
          return nil
        end
      elseif not (vim.wo.wrap or (function(_27_,_28_,_29_) return (_27_ <= _28_) and (_28_ <= _29_) end)(left_bound,vim.fn.virtcol("."),right_bound)) then
        local _30_ = to_next_in_window_pos_21(backward_3f, left_bound, right_bound, stopline)
        if (_30_ == "dead-end") then
          return cleanup()
        elseif true then
          local _ = _30_
          return iter(true)
        else
          return nil
        end
      elseif (vim.fn.foldclosed(line) ~= -1) then
        to_closed_fold_edge_21(backward_3f)
        local _32_ = skip_one_21(backward_3f)
        if (_32_ == "dead-end") then
          return cleanup()
        elseif true then
          local _ = _32_
          return iter(true)
        else
          return nil
        end
      else
        match_count = (match_count + 1)
        return pos
      end
    else
      return nil
    end
  end
  return iter
end
local function get_targets_2a(pattern, _36_)
  local _arg_37_ = _36_
  local backward_3f = _arg_37_["backward?"]
  local match_last_overlapping_3f = _arg_37_["match-last-overlapping?"]
  local wininfo = _arg_37_["wininfo"]
  local targets = _arg_37_["targets"]
  local source_winid = _arg_37_["source-winid"]
  local _let_38_ = get_horizontal_bounds()
  local left_bound = _let_38_[1]
  local right_bound_2a = _let_38_[2]
  local right_bound = dec(right_bound_2a)
  local whole_window_3f = wininfo
  local wininfo0 = (wininfo or vim.fn.getwininfo(vim.fn.win_getid())[1])
  local skip_curpos_3f = (whole_window_3f and (vim.fn.win_getid() == source_winid))
  local match_positions = get_match_positions(pattern, {left_bound, right_bound}, {["backward?"] = backward_3f, ["skip-curpos?"] = skip_curpos_3f, ["whole-window?"] = whole_window_3f})
  local targets0 = (targets or {})
  local prev_match = {}
  for _39_ in match_positions do
    local _each_40_ = _39_
    local line = _each_40_[1]
    local col = _each_40_[2]
    local pos = _each_40_
    local _41_ = get_char_at(pos, {})
    if (_41_ == nil) then
      if (col == 1) then
        table.insert(targets0, {wininfo = wininfo0, pos = pos, chars = {"\n"}, ["empty-line?"] = true})
      else
      end
    elseif (nil ~= _41_) then
      local ch1 = _41_
      local ch2 = (get_char_at(pos, {["char-offset"] = 1}) or "\n")
      local overlap_3f
      local function _43_()
        if backward_3f then
          return ((prev_match.col - col) == ch1:len())
        else
          return ((col - prev_match.col) == (prev_match.ch1):len())
        end
      end
      overlap_3f = ((line == prev_match.line) and _43_() and (__3erepresentative_char(ch2) == __3erepresentative_char((prev_match.ch2 or ""))))
      prev_match = {line = line, col = col, ch1 = ch1, ch2 = ch2}
      if (overlap_3f and match_last_overlapping_3f) then
        table.remove(targets0)
      else
      end
      if (not overlap_3f or match_last_overlapping_3f) then
        table.insert(targets0, {wininfo = wininfo0, pos = pos, chars = {ch1, ch2}, ["edge-pos?"] = ((ch2 == "\n") or (col == right_bound))})
      else
      end
    else
    end
  end
  if next(targets0) then
    return targets0
  else
    return nil
  end
end
local function distance(_48_, _50_)
  local _arg_49_ = _48_
  local l1 = _arg_49_[1]
  local c1 = _arg_49_[2]
  local _arg_51_ = _50_
  local l2 = _arg_51_[1]
  local c2 = _arg_51_[2]
  local editor_grid_aspect_ratio = 0.3
  local _let_52_ = {abs((c1 - c2)), abs((l1 - l2))}
  local dx = _let_52_[1]
  local dy = _let_52_[2]
  local dx0 = (dx * editor_grid_aspect_ratio)
  return pow((pow(dx0, 2) + pow(dy, 2)), 0.5)
end
local function get_targets(pattern, kwargs)
  local _local_53_ = kwargs
  local backward_3f = _local_53_["backward?"]
  local match_last_overlapping_3f = _local_53_["match-last-overlapping?"]
  local target_windows = _local_53_["target-windows"]
  if not target_windows then
    return get_targets_2a(pattern, kwargs)
  else
    local targets = {}
    local cursor_positions = {}
    local source_winid = vim.fn.win_getid()
    local curr_win_only_3f
    do
      local _54_ = target_windows
      if ((_G.type(_54_) == "table") and ((_G.type((_54_)[1]) == "table") and (((_54_)[1]).winid == source_winid)) and ((_54_)[2] == nil)) then
        curr_win_only_3f = true
      else
        curr_win_only_3f = nil
      end
    end
    local cross_win_3f = not curr_win_only_3f
    for _, _56_ in ipairs(target_windows) do
      local _each_57_ = _56_
      local winid = _each_57_["winid"]
      local wininfo = _each_57_
      if cross_win_3f then
        api.nvim_set_current_win(winid)
      else
      end
      cursor_positions[winid] = get_cursor_pos()
      get_targets_2a(pattern, {targets = targets, wininfo = wininfo, ["source-winid"] = source_winid, ["match-last-overlapping?"] = match_last_overlapping_3f})
    end
    if cross_win_3f then
      api.nvim_set_current_win(source_winid)
    else
    end
    if not empty_3f(targets) then
      local by_screen_pos_3f = (vim.o.wrap and (#targets < 200))
      if by_screen_pos_3f then
        for winid, _60_ in pairs(cursor_positions) do
          local _each_61_ = _60_
          local line = _each_61_[1]
          local col = _each_61_[2]
          local _62_ = vim.fn.screenpos(winid, line, col)
          if ((_G.type(_62_) == "table") and (nil ~= (_62_).row) and ((_62_).col == col)) then
            local row = (_62_).row
            cursor_positions[winid] = {row, col}
          else
          end
        end
      else
      end
      for _, _65_ in ipairs(targets) do
        local _each_66_ = _65_
        local _each_67_ = _each_66_["pos"]
        local line = _each_67_[1]
        local col = _each_67_[2]
        local _each_68_ = _each_66_["wininfo"]
        local winid = _each_68_["winid"]
        local t = _each_66_
        if by_screen_pos_3f then
          local _69_ = vim.fn.screenpos(winid, line, col)
          if ((_G.type(_69_) == "table") and (nil ~= (_69_).row) and ((_69_).col == col)) then
            local row = (_69_).row
            t["screenpos"] = {row, col}
          else
          end
        else
        end
        t["rank"] = distance((t.screenpos or t.pos), cursor_positions[winid])
      end
      local function _72_(_241, _242)
        return ((_241).rank < (_242).rank)
      end
      table.sort(targets, _72_)
      return targets
    else
      return nil
    end
  end
end
return {["get-horizontal-bounds"] = get_horizontal_bounds, ["get-match-positions"] = get_match_positions, ["get-targets"] = get_targets}

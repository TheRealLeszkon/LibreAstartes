import type { FilterOptions } from "../api/types";
import { ALL_TYPES, type FilterState } from "./filterState";

interface FilterRailProps {
  options: FilterOptions | null;
  filters: FilterState;
  onChange: (patch: Partial<FilterState>) => void;
  onReset: () => void;
  collapsed: boolean;
  onToggleCollapse: () => void;
  legionLocked?: boolean; // on the Legions tab the legion is pre-set
}

function toggle(list: string[], value: string): string[] {
  return list.includes(value) ? list.filter((v) => v !== value) : [...list, value];
}

export default function FilterRail({
  options,
  filters,
  onChange,
  onReset,
  collapsed,
  onToggleCollapse,
  legionLocked,
}: FilterRailProps) {
  return (
    <>
      <button
        className={collapsed ? "rail-handle collapsed" : "rail-handle"}
        onClick={onToggleCollapse}
        aria-label={collapsed ? "Show filters" : "Hide filters"}
        title={collapsed ? "Show filters" : "Hide filters"}
      >
        {collapsed ? "‹ Filters" : "Filters ›"}
      </button>

      <aside className={collapsed ? "filter-rail collapsed" : "filter-rail"} aria-hidden={collapsed}>
        <div className="rail-scroll">
          <div className="rail-row">
            <h3 className="rail-title">Search the Archive</h3>
            <button className="reset-btn" onClick={onReset}>
              Reset
            </button>
          </div>
          <input
            className="search-input"
            type="search"
            placeholder="Highlight by name…"
            value={filters.q}
            onChange={(e) => onChange({ q: e.target.value })}
          />

          <fieldset className="rail-group">
            <legend>Node Types</legend>
            <div className="chip-wrap">
              {ALL_TYPES.map((t) => (
                <label key={t} className={filters.types.includes(t) ? "chip on" : "chip"}>
                  <input
                    type="checkbox"
                    checked={filters.types.includes(t)}
                    onChange={() => onChange({ types: toggle(filters.types, t) })}
                  />
                  {t}
                </label>
              ))}
            </div>
          </fieldset>

          <fieldset className="rail-group">
            <legend>Allegiance</legend>
            <div className="chip-wrap">
              {["loyalist", "traitor"].map((a) => (
                <label key={a} className={filters.allegiance === a ? "chip on" : "chip"}>
                  <input
                    type="radio"
                    name="allegiance"
                    checked={filters.allegiance === a}
                    onChange={() => onChange({ allegiance: filters.allegiance === a ? undefined : a })}
                    onClick={() => filters.allegiance === a && onChange({ allegiance: undefined })}
                  />
                  {a}
                </label>
              ))}
            </div>
          </fieldset>

          <fieldset className="rail-group">
            <legend>Legions{legionLocked ? " (pre-set)" : ""}</legend>
            <div className="check-list">
              {options?.legions.map((l) => (
                <label key={l.id} className="check-row">
                  <input
                    type="checkbox"
                    checked={filters.legions.includes(l.id)}
                    onChange={() => onChange({ legions: toggle(filters.legions, l.id) })}
                  />
                  <span className="num">{l.numeral}</span> {l.name}
                </label>
              ))}
            </div>
          </fieldset>

          <fieldset className="rail-group">
            <legend>Chaos Powers</legend>
            <div className="chip-wrap">
              {options?.gods.map((g) => (
                <label key={g.id} className={filters.gods.includes(g.id) ? "chip on" : "chip"}>
                  <input
                    type="checkbox"
                    checked={filters.gods.includes(g.id)}
                    onChange={() => onChange({ gods: toggle(filters.gods, g.id) })}
                  />
                  {g.name}
                </label>
              ))}
            </div>
          </fieldset>

          <fieldset className="rail-group">
            <legend>Events</legend>
            <div className="check-list">
              {options?.events.map((e) => (
                <label key={e.id} className="check-row">
                  <input
                    type="checkbox"
                    checked={filters.events.includes(e.id)}
                    onChange={() => onChange({ events: toggle(filters.events, e.id) })}
                  />
                  {e.name}
                </label>
              ))}
            </div>
          </fieldset>

          <fieldset className="rail-group">
            <legend>Neighbourhood of Selected</legend>
            <div className="chip-wrap">
              {[0, 1, 2].map((d) => (
                <label key={d} className={filters.hood === d ? "chip on" : "chip"}>
                  <input
                    type="radio"
                    name="hood"
                    checked={filters.hood === d}
                    onChange={() => onChange({ hood: d })}
                  />
                  {d === 0 ? "Off" : `Depth ${d}`}
                </label>
              ))}
            </div>
          </fieldset>
        </div>
      </aside>
    </>
  );
}

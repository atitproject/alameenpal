/* ============================================================
   app-supabase.js — shared Supabase client + data API
   Requires (loaded before this file):
     1) https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2
     2) supabase-config.js
   ============================================================ */
(function () {
  const url = window.SUPABASE_URL || "";
  const key = window.SUPABASE_ANON_KEY || "";
  const configured = url && key && !url.includes("YOUR-PROJECT") && !key.includes("YOUR-ANON");

  const sb = configured ? window.supabase.createClient(url, key) : null;

  window.sb = sb;
  window.isConfigured = () => !!sb;

  // ---------- AUTH ----------
  window.auth = {
    signIn: (email, password) => sb.auth.signInWithPassword({ email, password }),
    signOut: () => sb.auth.signOut(),
    getSession: async () => (await sb.auth.getSession()).data.session,
  };

  // ---------- DATA API ----------
  window.db = {
    brands: {
      list:   () => sb.from("brands").select("*").order("sort").order("name"),
      add:    (r) => sb.from("brands").insert(r).select().single(),
      update: (id, r) => sb.from("brands").update(r).eq("id", id).select().single(),
      remove: (id) => sb.from("brands").delete().eq("id", id),
    },
    categories: {
      list:   () => sb.from("categories").select("*, brands(name)").order("sort").order("name"),
      add:    (r) => sb.from("categories").insert(r).select().single(),
      update: (id, r) => sb.from("categories").update(r).eq("id", id).select().single(),
      remove: (id) => sb.from("categories").delete().eq("id", id),
    },
    products: {
      list:   () => sb.from("products").select("*, categories(name, brands(name))").order("sort").order("name"),
      add:    (r) => sb.from("products").insert(r).select().single(),
      update: (id, r) => sb.from("products").update(r).eq("id", id).select().single(),
      remove: (id) => sb.from("products").delete().eq("id", id),
    },
    // Upload an image file to the "media" bucket, return its public URL
    uploadImage: async (file) => {
      const ext = (file.name.split(".").pop() || "jpg").toLowerCase();
      const path = `${Date.now()}-${Math.random().toString(36).slice(2, 8)}.${ext}`;
      const { error } = await sb.storage.from("media").upload(path, file, { upsert: false });
      if (error) throw error;
      return sb.storage.from("media").getPublicUrl(path).data.publicUrl;
    },
  };
})();
